// Neuron data
Neuron[] InputNeuron;
Neuron OutputNeuron;
Neuron[] HiddenNeuron;
int NeuronCount = 2;
int NeuronInputs = 2;
// Mutation control
float MutateBegin = -0.1;
float MutateEnd = 0.1;
// Blob parameters
float BlobX = width / 2, BlobY = width / 2;
float BlobAngle = 0;
float BlobSpeed = 1;

void Init()
{
  randomSeed(millis());
  InputNeuron = new Neuron[2];
  InputNeuron[0] = new Neuron(1);
  InputNeuron[1] = new Neuron(1);
  OutputNeuron = new Neuron(NeuronCount);
  HiddenNeuron = new Neuron[NeuronCount];
  for(int i = 0; i < NeuronCount; i++)
  {
    HiddenNeuron[i] = new Neuron(NeuronInputs);
    HiddenNeuron[i].Input[0] = InputNeuron[0];
    HiddenNeuron[i].Input[1] = InputNeuron[1];
  }
  for(int i = 0; i < NeuronCount; i++)
    OutputNeuron.Input[i] = HiddenNeuron[i];
}

void Run()
{
  background(255);
  // process neural network
  InputNeuron[0].Output = 1.0f * mouseX / width;
  InputNeuron[1].Output = 1.0f * mouseY / height;
  for(int i = 0; i < NeuronCount; i++)
    HiddenNeuron[i].Process();
  OutputNeuron.Process();
  // Move Blob
  stroke(0);
  text("Output: " + TWO_PI * (OutputNeuron.Output - 0.5), 100, 100);
  BlobAngle = TWO_PI * (OutputNeuron.Output - 0.5);
  BlobX += BlobSpeed * cos(BlobAngle);
  BlobY += BlobSpeed * sin(BlobAngle);
  BlobX = (BlobX + width) % width;
  BlobY = (BlobY + height) % height;
  // Draw blob
  blob_Main(BlobX, BlobY, HiddenNeuron);
  // learn
  float realAngle = atan2(mouseY - BlobY, mouseX - BlobX);
  float realValue = (realAngle / TWO_PI) + 0.5;
  text("Expect: " + realAngle, 400, 100);
  if(mousePressed) OutputNeuron.Teach(realValue);
  // else OutputNeuron.Learn();
  for(int i = 0; i < NeuronCount; i++)
  {
    // if(mousePressed) HiddenNeuron[i].Teach(realValue);
    // else HiddenNeuron[i].Learn();
    // HiddenNeuron[i].Mutate(InputNeuron, MutateBegin, MutateEnd);
  }
}


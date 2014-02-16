class Neuron
{
  float Output;
  Neuron[] Input;
  float[] Weight;
  float LearnRate;
  
  // Initialize
  Neuron(int inputs)
  {
    Output = random(-1, 1);
    Input = new Neuron[inputs];
    Weight = new float[inputs];
    for(int i = 0; i < inputs; i++)
      Weight[i] = random(-1, 1);
    LearnRate = random(0, 1);
  }
  
  // Process output
  void Process()
  {
    float inflow = 0.0f;
    for(int i = 0; i < Input.length; i++)
    {
      if(Input[i] == null) continue;
      inflow += Input[i].Output * Weight[i];
    }
    Output = 1 / (1 + exp(-inflow));
  }
  
  // Teach
  void Teach(float teachOutput)
  {
    float error = teachOutput - Output;
    for(int i = 0; i < Weight.length; i++)
    {
      float input = (Input[i] != null)? Input[i].Output : 0.0f;
      Weight[i] += LearnRate * input * error;
      Weight[i] = constrain(Weight[i], -1, 1);
    }
  }
  
  // Learn (unsupervised)
  void Learn()
  {
    for(int i = 0; i < Weight.length; i++)
    {
      float input = (Input[i] != null)? Input[i].Output : 0.0f;
      Weight[i] += LearnRate * input * (2 * Output - 1);
      Weight[i] = constrain(Weight[i], -1, 1);
    }
  }
  
  // Mutate (alter structure)
  void Mutate(Neuron[] neurons, float mutateBegin, float mutateEnd)
  {
    for(int i = 0; i < Input.length; i++)
    {
      float weight = (Input[i] != null)? Weight[i] : 0.0f;
      if(weight >= mutateBegin && weight <= mutateEnd)
      {
        int newNeuron = round(random(0, neurons.length - 1));
        Input[i] = neurons[newNeuron];
        Weight[i] = random(-1, 1);
      }
    }
  }
}


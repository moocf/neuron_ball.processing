// Draw blob's aura
void blob_Aura(float x, float y, Neuron[] neurons, int start)
{
  int i = start;
  float r = 255 * neurons[i].Output;
  float g = 255 * neurons[i+1].Output;
  float b = 255 * neurons[i+2].Output;
  float size = 200 * neurons[i+3].Output;
  noFill();
  stroke(r, g, b);
  strokeWeight(3);
  ellipse(x, y, size, size);
}

void blob_Main(float x, float y, Neuron[] neurons)
{
  noStroke();
  float r = 255 * neurons[1].Output;
  float g = 255 * neurons[constrain(2, 0, neurons.length - 1)].Output;
  float b = 255 * neurons[constrain(3, 0, neurons.length - 1)].Output;
  float size = 50 * (1 + neurons[constrain(4, 0, neurons.length - 1)].Output);
  noStroke();
  fill(r, g, b);
  ellipse(x, y, size, size);
  for(int i = 5; i < neurons.length - 4; i += 4)
    blob_Aura(x, y, neurons, i);
}


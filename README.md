# FNAL-Alveo-FPGA
## Basic concept and Environment
### Environment 
1. Test environment: FNAL LPC (Ailab01 with Alveo card), AWS F1 instance, 
2. FPGA plattform: Vitis-Ai by Xilinx(Ailab01), Xilinx ML suite(AWS f1 instance)
3. DNN model: ResNet-50 
## Vitis-Ai on Ailab 
### Environment setup
1. Please contact Burt on Slack to get the accessibility for FNAL Ailab and make sure you are in the "docker" user group to run a docker image for Vitis Ai.
2. Use `ssh username@ailab01.fnal.gov` to access Ailab in FNAL.
3. After getting into Ailab, type `cd Vitis-AI/`.
4. To run a docker for Vitis-Ai, type `./docker_run.sh xilinx/vitis-ai:tools-1.0.0-gpu` to activate docker image.
### Examples
#### Tensorflow
1. To run a tensorflow example, please make sure you are in the docker environment. 
2. Type `conda activate vitis-ai-tensorflow` to enable the virtual environment for tensorflow. 
3. Get the imagnet2012 data for the test run by  Collective Knowledge (CK).[1]
```
python -m ck pull repo:ck-env
python -m ck install package:imagenet-2012-val-min
python -m ck install package:imagenet-2012-aux
head -n 500 ~/CK-TOOLS/dataset-imagenet-ilsvrc2012-aux/val.txt > ~/CK-TOOLS/dataset-imagenet-ilsvrc2012-val-min/val.txt
```
4. Type `python getModels.py` to download models.
5. There are 6 kinds of model available now.


| inception_v1_baseline | inception_v4 | squeezenet |
|:---------------------:|:---------------:|:----------:|
|       ResNet-50       |   ResNet-101    | ResNet-152 |
6. To quantize the model, use the following command:
```
python run.py --quantize --model MODEL_FILE --pre_process MODEL --output_dir OUTPUT_DIR --input_nodes INPUT_NODES --output_nodes OUTPUT_NODES --input_shapes ?,?,?,? --batch_size batch_size

#You should change the argument to fit your model, input/outpu nodes and hyper parameters.
```
7. After quantize your model, use the command below to compile your model file and run inference.
```
python run.py --validate --model MODEL_FILE --pre_process MODEL --output_dir OUTPUT_DIR --input_nodes INPUT_NODES --output_nodes OUTPUT_NODES --c_input_nodes C_INPUT_NODES --c_output_nodes C_OUTPUT_NODES --input_shapes ?,?,?,?

#You should change the argument to fit your model, input/outpu nodes and hyper parameters.
```
8. For further example, please check the repository of Vitis-Ai.(https://github.com/Xilinx/Vitis-AI)

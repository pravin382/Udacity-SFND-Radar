# RADAR
## 1. Radar Target Generation and Detection 
In this project, we perform the following tasks:
- Configure the FMCW waveform based on the system requirements.
- Define the range and velocity of target and simulate its displacement.
- For the same simulation loop process the transmit and receive signal to determine the beat signal
- Perform Range FFT on the received signal to determine the Range
- Towards the end, perform the CFAR processing on the output of 2nd FFT to display the target.

![alt text](https://github.com/pravin382/Udacity-SFND-Radar/blob/master/pics/Project_radar_target_generation_and_detection.png)

### Radar System Requirements
|Frequency | 77 Ghz|
:----:|:----:
|Range Resolution | 1 m|
|Max Range | 200 m|
|Max velocity | 70 m/s|
|Velocity resolution| m m/s|

### Target velocity and range
velocity = -20 m/s <br /> 
range = 110 m

###  Transmitted, received and mixed signal generation
![alt text](https://github.com/pravin382/Udacity-SFND-Radar/blob/master/pics/signal_propagation.png)

### Range FFT (1st FFT)
#### FFT Operation
- Implement the 1D FFT on the Mixed Signal
- Reshape the vector into Nr*Nd array.
- Run the FFT on the beat signal along the range bins dimension (Nr)
- Normalize the FFT output with length, L = Bsweep * Tchirp.
- Take the absolute value of that output.
- Keep one half of the signal
- Plot the output
- There should be a peak at the initial position of the target. In our case at 110 m.

![alt text](https://github.com/pravin382/Udacity-SFND-Radar/blob/master/pics/frequency_and_Range.png)

###  2nd FFT for Range Doppler Map
![alt text](https://github.com/pravin382/Udacity-SFND-Radar/blob/master/pics/RDM.png)

### 2D CFAR
- Determine the number of Training cells for each dimension. Similarly, pick the number of guard cells. <br /> 
  ```
  %Select the number of Training Cells in both the dimensions.
  Tr = 5; % range cell
  Td = 5; % doppler cell

  %Select the number of Guard Cells in both dimensions around the Cell under 
  %test (CUT) for accurate estimation
  Gr = 2;
  Gd = 2;
  
  % offset the threshold by SNR value in dB
  offset = 5; 
  ```
- Slide the cell under test across the complete matrix. Make sure the CUT has margin for Training and Guard cells from the edges.
- For every iteration sum the signal level within all the training cells. To sum convert the value from logarithmic to linear using db2pow function.
- Average the summed values for all of the training cells used. After averaging convert it back to logarithmic using pow2db.
- Further add the offset to it to determine the threshold.
- Next, compare the signal under CUT against this threshold.
- If the CUT level > threshold assign it a value of 1, else equate it to 0.
- The process above will generate a thresholded block, which is smaller than the Range Doppler Map as the CUTs cannot be located at the edges of the matrix due to the presence of Target and Guard cells. Hence, those cells will not be thresholded. To keep the map size same as it was before CFAR, equate all the non-thresholded cells to 0.
```
[m,n] = size(RDM);
% Vector to hold threshold values 
threshold_cfar = zeros(m,n);
%Vector to hold final signal after thresholding
signal_cfar = zeros(m,n);
% number of cells for averaging
num_cells = (2*Tr + 2*Gr + 1)*(2*Td + 2*Gd + 1) - (2*Gr + 1)*(2*Gd + 1);

% loop for CUT
for i =  (Tr + Gr + 1):( m - 2*Tr - 2*Gr)
    for j = (Td + Gd + 1):(n - 2*Td - 2*Gd)
        % loop to calculate cfar
        threshold_cfar(i,j) = sum(sum(db2pow(RDM(i-(Tr+Gr) : i+(Tr+Gr),j-(Td+Gd) : j+(Td+Gd))))); 
        threshold_cfar(i,j) = threshold_cfar(i,j) - sum(sum(db2pow(RDM((i-Gr):(i+Gr),(j-Gd):(j+Gd)))));
        
        threshold_cfar(i,j) = threshold_cfar(i,j)/num_cells;
        % calculate the threshold
        threshold_cfar(i,j) = offset + pow2db(threshold_cfar(i,j));
        if RDM(i,j) > threshold_cfar(i,j)
            signal_cfar(i,j) = 1;
        end
    end
end
```
![alt text](https://github.com/pravin382/Udacity-SFND-Radar/blob/master/pics/cfar_sig.png)

### Reference
 [Udacity_Nanodegree_Sensor_fusion](https://www.udacity.com/course/sensor-fusion-engineer-nanodegree--nd313)
 
 ## 2. Sensor Fusion with Radar
![alt text](https://github.com/pravin382/Udacity-SFND-Radar/blob/master/pics/object_tracking_radar.png)
### Reference
 [Matlab_sensor_fusion_and_tracking](https://de.mathworks.com/help/driving/examples/sensor-fusion-using-synthetic-radar-and-vision-data.html)

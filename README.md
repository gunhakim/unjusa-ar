# 운주사 AR  
전라남도 화순의 운주사의 석탑과 석불을 ar로 구현

## demo
![Alt text](/demo/demo.jpeg)   

## 운주사의 탑/불상의 3d 모델링  
1. 탑/불상의 사진 촬영  
탑/불상의 360도 뷰를 촬영
사용 카메라: iPhone X, Samsung Galaxy S10, dji mavix2 zoom  
2. photogrammetry를 이용항 3d 모델 생성  
photoscan 사용  
![Alt text](/demo/photoscan.png)  
3. 3d모델 가공  
불필요한 부분 제거  
blender 사용  
![Alt text](/demo/blender.png)  
4. 3d모델 저장  
arkit에서 사용할 수 있는 obj형식으로 저장  
meshlab 사용  
![Alt text](/demo/meshlab.png)  

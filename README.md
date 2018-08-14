OpenGL Docker 
-------------

## How to build?
```
docker build -t opengl-docker .
```

## How to deploy this image?
```
docker run -d -p 5901:5901 opengl-docker 
```

## How to test OpenGL image?
On host
```
yum install tigervnc -y

vncviewer localhost:1    (Password: 123456)
```

## How to execute example source?
On terminal inside container, execute below command
```
./examplePic
```

![alt text][sample]

[sample]: ./opengl-example.png



## Reference
https://www.opengl.org/archives/resources/code/samples/glut_examples/examples/examples.html
https://github.com/CentOS/CentOS-Dockerfiles/blob/master/firefox/centos6/Dockerfile

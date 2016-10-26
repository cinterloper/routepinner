if [ "$gwip" == "" ]
then
  echo "you need to set the gwip variable" 1>&2 
  exit -1
fi
docker run -t -i -v $(pwd):/opt/routepinner --net=host --cap-add=NET_ADMIN -e gwip routepinner bash


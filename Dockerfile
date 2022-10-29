## builds MNN for arm64
FROM arm64v8/debian:sid AS build
RUN apt-get update && apt-get install -y \
  git \
  cmake \
  wget \
  libprotobuf-dev \
  protobuf-compiler \
  gcc
RUN git clone --depth=1 https://github.com/alibaba/MNN.git
WORKDIR MNN
RUN ./schema/generate.sh
WORKDIR build
RUN cmake -D CMAKE_BUILD_TYPE=Release \
  -D MNN_OPENMP=ON \
  -D MNN_USE_THREAD_POOL=OFF \
  -D MNN_BUILD_QUANTOOLS=ON \
  -D MNN_BUILD_CONVERTER=ON \
  -D MNN_BUILD_DEMO=ON \
  -D MNN_BUILD_BENCHMARK=ON ..
RUN make -j4

## copy root tar
FROM scratch AS mnn
USER root
COPY /root.tar /
COPY --from=build /MNN /

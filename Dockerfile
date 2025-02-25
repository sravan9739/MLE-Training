FROM continuumio/miniconda3

LABEL maintainer="Sravan Kumar M"

COPY deploy/conda/linux_cpu_py39.yml env.yml
RUN conda env create -n housing -f env.yml

RUN git clone https://github.com/sravan9739/mle-training.git

RUN cd mle-training \
    && conda run -n housing pip install .\
    && conda run -n housing pytest tests/functional_tests/

CMD ["/bin/bash"]

COPY entrypoint.sh .
ENTRYPOINT [ "./entrypoint.sh" ]
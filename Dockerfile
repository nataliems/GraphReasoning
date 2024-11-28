# Use a lightweight Python base image
FROM python:3.10-slim

# Install system dependencies needed for Python and Git
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl git build-essential && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set environment variables for Python
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /workspace

# Copy and install the GraphReasoning repository in editable mode
COPY GraphReasoning /workspace/GraphReasoning
RUN pip install --no-cache-dir -e /workspace/GraphReasoning

# Install Python dependencies
RUN pip install --no-cache-dir \
	jupyterlab \
	transformers \
	huggingface_hub \
	networkx \
	pandas \
	numpy \
	matplotlib \
	pyvis \
	tqdm \
	seaborn \
	ipywidgets \
	optimum \
	auto-gptq \
	langchain-community \
	llama-index-embeddings-huggingface

# Expose the default JupyterLab port
EXPOSE 8888

# Set the command to launch JupyterLab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]

# @misc{Buehler2024AcceleratingDiscoveryGraphReasoning,
#    author = {Buehler, Markus J.},
#    title = {Accelerating Scientific Discovery with Generative Knowledge Extraction, Graph-Based Representation, and Multimodal Intelligent Graph Reasoning},
#    year = {2024},
#    eprint = {2403.11996},
#    archivePrefix = {arXiv},
#    doi = {10.48550/arXiv.2403.11996},
#    url = {https://doi.org/10.48550/arXiv.2403.11996}
#}

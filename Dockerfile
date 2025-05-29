# Dockerfile
FROM continuumio/miniconda3

# Install system dependencies like git
RUN apt-get update && apt-get install -y git

#  Clone your repo into a known location (e.g., /workspace)
RUN git clone https://github.com/m-edal/Time-series-analytics-course.git /workspace

# Copy the environment file into the container
COPY environment.yml /tmp/environment.yml

# Create the environment
RUN conda env create -f /tmp/environment.yml

# Set the environment to activate
ENV PATH /opt/conda/envs/timeseries/bin:$PATH
# Replace <env_name> with the actual environment name from your environment.yml

# Activate the environment
SHELL ["conda", "run", "-n", "timeseries", "/bin/bash", "-c"]

# Set working directory
WORKDIR /workspace

# Expose port for Jupyter
EXPOSE 8888

# Start Jupyter Lab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]

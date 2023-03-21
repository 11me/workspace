# Workspace container

```yaml
| Number | Program Name | Version |
|--------|--------------|---------|
| 1      | Helm         | 3.8.2   |
| 2      | Helmfile     | 0.144.0 |
| 3      | AWS CLI      | latest  |
| 4      | kubectl      | 1.24.0  |
| 5      | Neovim       | 0.8.3   |
| 6      | Go           | 1.20.3  |

```

```sh
docker build --rm -t 11me/workspace .

docker run --name workspace -it --network host \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /home/lime:/home/lime \
    -v /tmp/.X11-unix/tmp/.X11-unix \
    -e DISPLAY=$DISPLAY \
    11me/workspace
```

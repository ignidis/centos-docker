# centos-docker
The original centos image updated to the current patch level and compressed to reduce size.

I applied the fixes recomended by upstream to enable systemd, no sure if systemd makes sense in a container, but it is in the image anyway and can not be removed, so what ?
Some unnecessary stuff has also been removed (man pages, info pages, locales besides of EN-US).
I keep the TZDATA just in case, but actually it would be better to remove and mount a read-only volume from the host.
I also decided to keep python, just in case i want to use it instead of bash scripts.

This is the base image for my openshift images.
The goal is to generate a dependency via S2I and let openshift trigger the building processes for the service images whenever i update this image, a real CI/CD pipeline ...
But until i'm there though, a cron job will probably do the image maintenance job.
The upload of the updated images to the registry will force openshift to restart the service containers with the new images.

# hotl-suite
Contains support scripts and configurations but not source code for HOTL instances
## HOTL instances
There are four instances of HOTL in existence as of November 2018. Each has its own servers running in the cloud.
### Consumer/FOD
fbqserver4b00.weather.com - production

qafbqserver4b00.weather.com - QA/Dev
### AVFCST/EnRoute
avf-ds-a1 and avf-ds-a2 - production and backup linux/postgres/web server
avf-es-a1 and avf-es-a2 - production and backup Windows HOTL server

avf-ds-qb1 - QA/Dev linux/postgres/web server
avf-es-qb1 - QA/Dev Windows HOTL server
### RadarPlus
radarplus-east-ldm-prod.wsi.com - production linux/LDM server
radarplus-east-hotl-prod.wsi.com - production Windows HOTL server
RDS: radarplus-east-a - production RDS database for HOTL

radarplus-west-ldm-prod.wsi.com - backup production linux/LDM server
radarplus-west-hotl-prod.wsi.com - backup production Windows HOTL server
RDS: radarplus-west-a - backup production RDS database for HOTL

radarplus-east-ldm-stage.wsi.com - QA/Dev linux/LDM server
radarplus-east-hotl-stage.wsi.com - QA/Dev Windows HOTL server
RDS: radarplus-east-b - QA/Dev RDS database for HOTL

### LongView
longview-east-ldm-prod.wsi.com - production linux/LDM server
longview-east-hotl-prod.wsi.com - production Windows HOTL server
RDS: longview-east-a - production RDS database for HOTL

longview-west-ldm-prod.wsi.com - backup production linux/LDM server
longview-west-hotl-prod.wsi.com - backup production Windows HOTL server
RDS: longview-west-a - backup production RDS database for HOTL

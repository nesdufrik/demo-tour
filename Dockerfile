FROM node:lts
COPY . .
RUN npm install
RUN npm run build
RUN npm run start
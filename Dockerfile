FROM node:lts
COPY . .
RUN npm install
RUN npm run build
CMD ["node","dist/index.js"]
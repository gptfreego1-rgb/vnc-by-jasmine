FROM --platform=linux/amd64 ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update -y && apt install --no-install-recommends -y xfce4 xfce4-goodies tigervnc-standalone-server novnc websockify sudo xterm init systemd snapd vim net-tools curl wget git tzdata unzip openjdk-8-jre
RUN apt update -y && apt install -y dbus-x11 x11-utils x11-xserver-utils x11-apps
RUN apt update -y && apt install -y xubuntu-icon-theme
RUN wget -q https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/microemu/microemulator-2.0.4.zip && unzip microemulator-2.0.4.zip -d /opt/microemulator && rm microemulator-2.0.4.zip
RUN wget -q https://files.catbox.moe/zqrena.zip && mv zqrena.zip /opt/microemulator/avatar.jar
RUN mkdir -p /root/Desktop && echo '[Desktop Entry]' > /root/Desktop/microemulator.desktop && echo 'Type=Application' >> /root/Desktop/microemulator.desktop && echo 'Name=MicroEmulator' >> /root/Desktop/microemulator.desktop && echo 'Exec=java -noverify -Xmx50m -jar /opt/microemulator/microemulator.jar /opt/microemulator/avatar.jar' >> /root/Desktop/microemulator.desktop && echo 'Icon=utilities-terminal' >> /root/Desktop/microemulator.desktop && echo 'Terminal=false' >> /root/Desktop/microemulator.desktop && chmod +x /root/Desktop/microemulator.desktop
RUN touch /root/.Xauthority
EXPOSE 5901
EXPOSE 6080
CMD bash -c "vncserver -localhost no -SecurityTypes None -geometry 1024x768 --I-KNOW-THIS-IS-INSECURE && openssl req -new -subj '/C=JP' -x509 -days 365 -nodes -out self.pem -keyout self.pem && websockify -D --web=/usr/share/novnc/ --cert=self.pem 6080 localhost:5901 && tail -f /dev/null"

# Ruby und einige Ruby-Bibliotheken muessen installiert sein
# fuer Ubuntu 10.04 und Standard Ruby 1.8 z.B. folgende Befehle benutzen
# sudo aptitude install ruby-full rubygems librqrcode-ruby libmagickcore-dev libmagickwand-dev imagemagick
# sudo gem install rmagick

# Parameter fuer QR Code
text = 'ulblink.tu-darmstadt.de/'
size = 4
level = 'h'
 
# Lade notwendige Bibliotheken
require 'rubygems'
require 'rqrcode'

# Lade Bibliothek
require 'qr_library'

# Schleife zur Erzeugung der Abbildungen
for t in [

	#************************************************************
	# Hier Rubyinput aus Tabelle Demodatenquelle einkopieren
	#************************************************************
	'228344530',
	'128109696',
	'184930278'
	#************************************************************
	# Am Ende der letzten Zeile darf kein Komma stehen
	#************************************************************

	]

# Kontrollausgabe auf der Kommandozeile
print t+' '

qr = RQRCode::QRCode.new(text+t,  :size => size, :level => level)

# Erzeuge das Bild mit dem QR-Code und verdopple die Groesse
img = QRImage.new(qr).sample(2)
 
# Schreibe das Bild auf die Festplatte
img.write('./images/barcode'+t+'.png') { quality = 100 }

# Programmende
end


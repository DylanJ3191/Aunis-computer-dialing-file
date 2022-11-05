address = {"Glyph 1", "Glyph 2", "Glyph 3", "Glyph 4", "Glyph 5", "Glyph 6", "Glyph 7(optional, if unused delete)", "Glyph 8(optional, if unused delete)", "Point of Origin"} -- Replace 'glyph #' with '[Name of glyph (eg. Triangulum)]'

c = require("component")
event = require("event")
os = require("os")
sg = c.stargate

print("Dialing")
for i,v in ipairs(address) do print(i,v) end
print()

function dialNext(dialed)
	glyph = address[dialed + 1]
	print("Encoding "..glyph.."... ")
	
	sg.engageSymbol(glyph)
end

eventID = event.listen("stargate_spin_chevron_engaged", function(evname, address, caller, num, lock, glyph)
		os.sleep(2)
		
		if lock then
			if (event.cancel(eventID)) then
				print("Event cancelled sucessfully")
			end
			
			os.sleep(2)
			
			print("Establishing wormhole...")
			sg.engageGate()
			
			doing = false
		else
			dialNext(num)
		end
	end)

dialNext(0)
doing = true

while doing do os.sleep(0.1) end

os.sleep(30) -- how long in seconds before the gate shutsdown automatically
sg.disengageGate()

local InterfaceManager = {}

_G.setclipboard = write_clipboard or writeclipboard or setclipboard or set_clipboard or nil
_G.request = http_request or request or httprequest or nil
_G.readfile = readfile or read_file or nil
_G.writefile = writefile or write_file or nil
_G.isfile = isfile or is_file or nil

local ConfigFile = "ThemeConfig.json"

local Hensuu = {
	SelectedTheme = "Default",
}

local Theme = {
	"Default",
	"Bliz_T",
	"Chili",
	"Forest",
	"Sunset",
	"Ocean",
	"Candy",
	"Retro",
}

local function SaveConfig()
	if _G.writefile then
		local data = game:GetService("HttpService"):JSONEncode(Hensuu)
		_G.writefile(ConfigFile, data)
	end
end

local function LoadConfig()
	if _G.isfile and _G.readfile and _G.isfile(ConfigFile) then
		local success, data = pcall(function()
			return game:GetService("HttpService"):JSONDecode(_G.readfile(ConfigFile))
		end)
		if success and data.SelectedTheme then
			Hensuu.SelectedTheme = data.SelectedTheme
		end
	end
end

LoadConfig()

function InterfaceManager:SetLibrary(Library)
	self.Library = Library
	if self.Library and self.Library.SetTheme then
		self.Library.SetTheme(Hensuu.SelectedTheme)
	end
end

function InterfaceManager:BuildInterfaceSection(Tabs)
	assert(self.Library, "Must set InterfaceManager.Library")
	local Library = self.Library
	local section = Tabs:AddSection({Name = "InterfaceManager"})

	Tabs:AddDropdown({
		Name = "Theme",
		Default = Hensuu.SelectedTheme,
		Options = Theme,
		Callback = function(Value)
			Hensuu.SelectedTheme = Value
			SaveConfig()
		end    
	})

	Tabs:AddButton({
		Name = "Apply Theme",
		Callback = function()
			Library.SetTheme(Hensuu.SelectedTheme)
			SaveConfig()
		end    
	})
end

return InterfaceManager

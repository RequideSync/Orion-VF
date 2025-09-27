local InterfaceManager = {}
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

function InterfaceManager:SetLibrary(Library)
	self.Library = Library
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
		end    
	})
	
	Tabs:AddButton({
		Name = "Apply Theme",
		Callback = function()
			Library.SetTheme(Hensuu.SelectedTheme)
		end    
	})
end

return InterfaceManager

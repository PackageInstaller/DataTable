-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetMallDlg.lua

local MallDlgBase = require("UI/MainState/Trade/MallDlgBase")
local strClassName = "PetMallDlg"
local PetMallDlg = Class(strClassName, MallDlgBase)

function PetMallDlg:ctor()
	return
end

function PetMallDlg:initConfig()
	self.tabTypeConfig = {
		[6] = true
	}
	self.tabPrefabName = "System/Pet/TabPetStore"
end

return PetMallDlg

-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\BattleBossIntroDlg.lua

local BattleBossIntroDlg = Class("BattleBossIntroDlg", UIControls.Window)

function BattleBossIntroDlg:ctor()
	self:initUI()
end

function BattleBossIntroDlg:initUI()
	self.txtName = UIControls.Label(self, "BgPanel/BgName/TextName")
	self.txtDescribe = UIControls.Label(self, "BgPanel/TextDes")
	self.imgRole = UIControls.Role(self, "BgPanel/GridHeroPortrait", 0, 0)
end

function BattleBossIntroDlg:setInfo(info, cb)
	self.txtName:setText(info.monster_name)
	self.txtDescribe:setText(info.monster_describe)
	self.imgRole:showRole(info.imgId)

	self.closeCb = cb
end

function BattleBossIntroDlg:destroy()
	BattleBossIntroDlg.super.destroy(self)

	if self.closeCb then
		self.closeCb()
	end
end

return BattleBossIntroDlg

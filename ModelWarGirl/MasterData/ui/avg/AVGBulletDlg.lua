-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\AVG\\AVGBulletDlg.lua

local strClassName = "AVGBulletDlg"
local AVGBulletDlg = Class(strClassName, UIControls.Window)

function AVGBulletDlg:ctor(...)
	self.panel = UIControls.Panel(self, "BulletScreen")
	self.screenController = self:getController():GetCom(UIConst.ControlTypeBulletScreen, "BulletScreen")
end

local AVGBulletType = 9

function AVGBulletDlg:addBullet(content)
	if not content or content == "" then
		return
	end

	if not tolua.isnull(self.screenController) then
		self.screenController:AddBullet("", content, AVGBulletType, utils.isLargeEmoji(content) ~= nil)
	end
end

function AVGBulletDlg:clearAll(...)
	if not tolua.isnull(self.screenController) then
		self.screenController:ClearAll()
	end
end

function AVGBulletDlg:setState(nowState)
	if nowState == nil or self.showState == nowState then
		return
	end

	self.showState = nowState

	if not tolua.isnull(self.screenController) then
		if nowState then
			self.screenController:ChangeHeightRange(1)
		else
			self.screenController:ChangeHeightRange(0)
		end
	end
end

return AVGBulletDlg

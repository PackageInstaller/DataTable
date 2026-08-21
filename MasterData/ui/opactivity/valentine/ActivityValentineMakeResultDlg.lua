-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\Valentine\\ActivityValentineMakeResultDlg.lua

local strClassName = "ActivityValentineMakeResultDlg"
local ActivityValentineMakeResultDlg = Class(strClassName, UIControls.Window)

function ActivityValentineMakeResultDlg:ctor()
	self:initUI()
end

function ActivityValentineMakeResultDlg:initUI()
	self.btnShare = UIControls.Button(self, "Bg/BtnConfirm")

	self.btnShare:addEventClick(self.onBtnShare)

	self.textGetName = UIControls.Label(self, "Bg/TextAward")
	self.panelNew = UIControls.Panel(self, "Bg/NewNode")
end

function ActivityValentineMakeResultDlg:setData(actObj, makeInfo, preGetState)
	self.actObj = actObj
	self.makeMaterial = makeInfo[1]
	self.makeItem = makeInfo[2]

	local clientItem = BaseObject.GetObject(self.makeItem, 1)

	self.textGetName:setText(string.format(Lang.get(65472), clientItem.name or ""))

	self.gridGet = UIControls.getGridChild(clientItem, self, "Bg/AwardList/Content")

	self.gridGet:setVisible(true)
	self.gridGet:setObj(clientItem)

	if self.makeItem ~= self.actObj.actData.miscData.extra_gift_id then
		self.btnShare:setVisible(true)
		self.panelNew:setVisible(preGetState and not preGetState[self.makeItem])
	else
		self.btnShare:setVisible(false)
		self.panelNew:setVisible(false)
	end
end

function ActivityValentineMakeResultDlg:onBtnShare()
	self:setVisible(false)
	self.actObj.actData:onShareMakeMaterial(self.makeItem)
end

return ActivityValentineMakeResultDlg

-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Tips\\ItemGuidePanel.lua

local ResColor = require("ClientData/ResColor")
local ResGuideGet = require("ClientData/ResGuideGet")
local ResJumpGuide = require("ClientData/ResJumpGuide")
local JumpGuideManager = JumpGuideManager
local ItemGuideCell = Class("ItemGuideCell", UIControls.Child)

function ItemGuideCell:ctor()
	self.textName = UIControls.Label(self, "TextName")
	self.textState = UIControls.Label(self, "TextState")
	self.imgState = UIControls.Image(self, "IconState")
	self.btnGo = UIControls.Button(self, "")

	self.btnGo:addEventClick(self.onGoClick)
end

function ItemGuideCell:setData(guideId)
	self.data = ResGuideGet[guideId]

	if not self.data then
		self:setVisible(false)

		return
	end

	self.textName:setText(self.data.guide_title or "")

	self.conditions = {}

	local cFunc = self.data.condition_func or ""
	local cArgs = self.data.condition_args or {}
	local func = CurAvatar[cFunc]

	if func then
		self.conditions = func(CurAvatar, cArgs)
	end

	if self.conditions and self.conditions.locked or self.conditions.invaildNotice then
		self.btnGo:setImage("Atlas/CommonAtlas/BtnAtlas2", "BtnTipDis")
		self.imgState:setImage("Atlas/CommonAtlas/TipsNewAtlas", "IconSignLockDis")
		self.textState:setText(Lang.get(195))
		self.textName:setFontColor(ResColor.GREYMIDDLE)
		self.textState:setFontColor(ResColor.GREYMIDDLE)
	elseif self.conditions and self.conditions.closed then
		self.btnGo:setImage("Atlas/CommonAtlas/BtnAtlas2", "BtnTipDis")
		self.imgState:setImage("Atlas/CommonAtlas/TipsNewAtlas", "IconSignTimeDis")
		self.textState:setText(Lang.get(30242))
		self.textState:setFontColor(ResColor.GREYMIDDLE)
		self.textName:setFontColor(ResColor.GREYMIDDLE)
	elseif self.conditions and self.conditions.willUnlock then
		self.textState:setText(self.conditions.num .. "/" .. self.conditions.tNum)
		self.textState:setFontColor(ResColor.WHITE)
		self.textName:setFontColor(ResColor.WHITE)
		self.textState:setText(Lang.get(30243))
		self.btnGo:setImage("Atlas/CommonAtlas/BtnAtlas2", "BtnTipNml")
		self.imgState:setImage("Atlas/CommonAtlas/TipsNewAtlas", "IconSignNml")
	elseif self.conditions and self.conditions.invaildFunc then
		self.btnGo:setImage("Atlas/CommonAtlas/BtnAtlas2", "BtnTipDis")
		self.imgState:setImage("Atlas/CommonAtlas/TipsNewAtlas", "IconSignLockDis")
		self.textState:setText(Lang.get(195))
		self.textName:setFontColor(ResColor.GREYMIDDLE)
		self.textState:setFontColor(ResColor.GREYMIDDLE)
	elseif self.conditions and self.conditions.tNum and self.conditions.tNum > 0 then
		self.textState:setText(self.conditions.num .. "/" .. self.conditions.tNum)
		self.textState:setFontColor(ResColor.WHITE)
		self.textName:setFontColor(ResColor.WHITE)
		self.btnGo:setImage("Atlas/CommonAtlas/BtnAtlas2", "BtnTipNml")
		self.imgState:setImage("Atlas/CommonAtlas/TipsNewAtlas", "IconSignNml")
	else
		self.textState:setFontColor(ResColor.WHITE)
		self.textName:setFontColor(ResColor.WHITE)
		self.btnGo:setImage("Atlas/CommonAtlas/BtnAtlas2", "BtnTipNml")
		self.imgState:setImage("Atlas/CommonAtlas/TipsNewAtlas", "IconSignNml")
		self.textState:setText("")
	end

	self:setVisible(true)
end

local NOTICE_LOCKED = 101
local NOTICE_CLOSED = 102
local NOTICE_TIMES_OVER = 103

function ItemGuideCell:onGoClick(sender)
	if self.conditions.locked then
		MsgManager.clientNotice(NOTICE_LOCKED)

		return
	elseif self.conditions.closed then
		MsgManager.clientNotice(NOTICE_CLOSED)

		return
	elseif self.conditions.invaildNotice then
		MsgManager.clientNotice(self.conditions.invaildNotice)

		return
	elseif self.conditions.invaildFunc then
		self.conditions.invaildFunc(self.conditions)

		return
	elseif self.conditions.tNum and self.conditions.tNum > 0 and self.conditions.num <= 0 then
		MsgManager.clientNotice(NOTICE_TIMES_OVER)

		return
	end

	if self.data.link_id then
		self.mWindow:setVisible(false)

		if self.mParent.uiConfig and self.mParent.uiConfig.CloseSrcWindow and self.mParent.srcGrid and (not ResJumpGuide[self.data.link_id] or not ResJumpGuide[self.data.link_id].param_1 or ResJumpGuide[self.data.link_id].param_1 ~= self.mParent.srcGrid.mWindow.mUIName) then
			self.mParent.srcGrid.mWindow:setVisible(false)
		end

		JumpGuideManager.jump(self.data.link_id, nil, self.mParent.srcGrid)
	end
end

function ItemGuideCell:checkSpecialState(linkId)
	if linkId and linkId == 21 and GameFsm.isInState(Const.STATE_MAIN_MAZE) == true then
		return false
	else
		return true
	end
end

local ItemGuidePanel = Class("ItemGuidePanel", UIControls.Panel)

function ItemGuidePanel:ctor()
	self.guildCells = {}
end

function ItemGuidePanel:show(guideIds, srcGrid, uiConfig)
	if guideIds == nil then
		return
	end

	local validIds = {}

	for _, guideId in ipairs(guideIds) do
		local guideData = ResGuideGet[guideId]

		if guideData and guideData.show_func and CurAvatar[guideData.show_func] then
			if CurAvatar[guideData.show_func](CurAvatar, guideData.show_args, srcGrid) then
				table.insert(validIds, guideId)
			end
		elseif guideData then
			table.insert(validIds, guideId)
		end
	end

	for index = #self.guildCells, #validIds - 1 do
		local newGuild = ItemGuideCell(self, self.mPath, "System/Common/Tips/BtnTipsWay")

		table.insert(self.guildCells, newGuild)
	end

	for i, cell in ipairs(self.guildCells) do
		if validIds[i] then
			cell:setVisible(false)
			cell:setData(validIds[i])
		else
			cell:setVisible(true)
		end
	end

	self.srcGrid = srcGrid
	self.uiConfig = uiConfig

	self:setVisible(#validIds ~= 0)
end

return ItemGuidePanel

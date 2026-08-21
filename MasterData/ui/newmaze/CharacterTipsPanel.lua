-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\CharacterTipsPanel.lua

local HeroCharacterGrid = require("UI/NewMaze/HeroCharacterGrid")
local RectTransformType = typeof(UnityEngine.RectTransform)
local ResNewMazeDisplay = require("ClientData/ResNewMazeDisplay")
local ResNewMazeFeature = require("ClientData/ResNewMazeFeature")
local PIVOT_VALUE = Vector2(0.5, 1)
local CharacterTipsPanel = Class("CharacterTipsPanel", UIControls.Child)

function CharacterTipsPanel:ctor(...)
	self:initUI()
end

function CharacterTipsPanel:initUI(...)
	self.bg = UIControls.Image(self, "ScrollView/Content/Bg")
	self.textTitle = UIControls.Label(self, "ScrollView/Content/TextTitle")
	self.textDes = UIControls.Label(self, "ScrollView/Content/TextDes")
	self.textNum = UIControls.Label(self, "ScrollView/Content/TextNum")
	self.lvUpAttr2 = UIControls.Panel(self, "ScrollView/Content/LvUpAttr2")
	self.textLvUpTitle = UIControls.Panel(self, "ScrollView/Content/TextLvUpTitle")
	self.textCondition = UIControls.Label(self, "ScrollView/Content/TextCondition")
	self.lvUpAttr3 = UIControls.Panel(self, "ScrollView/Content/LvUpAttr3")
	self.usePanel = UIControls.Panel(self, "ScrollView/Content/UsePanel")
	self.btnUse = UIControls.Button(self, "ScrollView/Content/UsePanel/BtnUse")

	self.btnUse:addEventClick(self.onBtnUseClick)

	self.content = UIControls.Panel(self, "ScrollView/Content")
	self.textUseNum = UIControls.Label(self, "ScrollView/Content/UsePanel/BtnUse/TextNum")
	self.btnIcon = UIControls.Image(self, "ScrollView/Content/UsePanel/BtnUse/Icon")
end

function CharacterTipsPanel:setData(data, isInMainDlg)
	self.data = data
	self.isInMainDlg = isInMainDlg
	self.type = self.data.type

	self.lvUpAttr2:setVisible(false)
	self.textLvUpTitle:setVisible(false)
	self.textCondition:setVisible(false)
	self.lvUpAttr3:setVisible(false)
	self.usePanel:setVisible(self.type == 1 and isInMainDlg)
	self.textTitle:setText(self.data.name)
	self.textDes:setText(self.data.desc)

	self.needRedHeartNum = ResNewMazeFeature[self.data.id].param[1] or 1

	if self.data.id == Const.NEW_MAZE_SKILL_ID_USE_REDHEART then
		self.textUseNum:setText(self.needRedHeartNum)
		self.textUseNum:setVisible(true)
		self.btnIcon:setVisible(true)
	else
		self.textUseNum:setVisible(false)
		self.btnIcon:setVisible(false)
	end

	if self.grid == nil then
		self.grid = HeroCharacterGrid(self, "ScrollView/Content/GridPanel", "System/Rogue/GridCharacter", 0, 0, true)
	end

	self.grid:setData(self.data)
	self:setLayoutSize(nil, self.content:getRectSize().height)

	if self.isInMainDlg then
		local rect = self:getController():GetComponent(RectTransformType)

		rect.pivot = PIVOT_VALUE
	end

	if self.type == 1 then
		if not self.data.use_cd then
			self.textNum:setVisible(false)
		else
			self.textNum:setVisible(true)
			self.textNum:setText(self.data.use_cd)
		end
	else
		self.textNum:setVisible(false)
	end
end

function CharacterTipsPanel:onBtnUseClick()
	if self.mWindow.actObj:inFreeze() then
		MsgManager.notice(Lang.get(32793))

		return
	end

	if self.isInMainDlg then
		if self.data.id == Const.NEW_MAZE_SKILL_ID_USE_REDHEART or self.data.id == Const.NEW_MAZE_SKILL_ID_GET_COIN then
			if self.mWindow.actObj.actData.redheart <= self.needRedHeartNum then
				MsgManager.notice(string.format(ResNewMazeDisplay[13060062].desc, self.needRedHeartNum))

				return
			end

			local function yesFunc()
				RPC.newMazeFeatureUse(self.mWindow.actObj.opId, self.data.id)
				self:setVisible(false)
			end

			local content = string.format(ResNewMazeDisplay[13060045].desc, self.needRedHeartNum)

			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", content, yesFunc)
		elseif self.data.id == Const.NEW_MAZE_SKILL_ID_REFRESH_NODE then
			if self.mWindow.alreadyChooseNode then
				MsgManager.notice(ResNewMazeDisplay[13060066].desc)

				return
			end

			if self.mWindow.newMazeData.ratingLevel == 1 then
				MsgManager.notice(ResNewMazeDisplay[13060069].desc)

				return
			end

			if self.mWindow.newMazeData.curLayerNodeId then
				local layerNodeData = self.mWindow.newMazeData.nodeTableData[self.mWindow.newMazeData.ratingLevel][self.mWindow.newMazeData.curLayerNodeId]

				if layerNodeData and layerNodeData.node_type == 1 then
					-- block empty
				else
					MsgManager.notice(ResNewMazeDisplay[13060070].desc)

					return
				end
			end

			local canUse = self:checkLayerCD(self.data.use_cd)

			if canUse then
				RPC.newMazeFeatureUse(self.mWindow.actObj.opId, self.data.id)
				self:setVisible(false)
			else
				MsgManager.notice(string.format(ResNewMazeDisplay[13060067].desc, self.data.use_cd))
			end
		elseif self.data.id == 108 then
			local canUse = self:checkLayerCD(self.data.use_cd or 3)

			if canUse then
				RPC.newMazeFeatureUse(self.mWindow.actObj.opId, self.data.id)
				self:setVisible(false)
			end
		end
	end
end

function CharacterTipsPanel:checkLayerCD(cd)
	self.featureUseRecord = self.mWindow.actObj.actData.featureUseRecord
	self.curLayer = self.mWindow.actObj.actData.layer

	if self.featureUseRecord then
		for i, record in pairs(self.featureUseRecord or {}) do
			if record.id == self.data.id then
				if record.last_use_layer ~= 0 and record.last_use_layer + cd > self.curLayer then
					return false
				end

				break
			end
		end
	end

	return true
end

return CharacterTipsPanel

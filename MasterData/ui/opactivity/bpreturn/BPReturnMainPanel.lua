-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\BPReturn\\BPReturnMainPanel.lua

local ResRandClient = require("ClientData/ResRandClient")
local BpCell = Class("BpReturnCell", UIControls.ScrollViewLoopCell)
local BG_ImageData = {
	filePath = "Atlas/ReturnAtlas/ReturnBPAtlas3",
	spriteName = {
		"BgReceivedShading",
		"BgCollectableShading",
		"BgNoCollectableShading"
	}
}
local BGLV_ImageData = {
	filePath = "Atlas/ReturnAtlas/ReturnBPAtlas",
	spriteName = {
		"BgReceived",
		"BgCollectable",
		"BgNoCollectable"
	}
}

function BpCell:ctor()
	self.imgBg = UIControls.Image(self, "Bg")
	self.slider = UIControls.Slider(self, "Bg/Slider")
	self.imgLv = UIControls.Image(self, "Bg/BgLv")
	self.textLevel = UIControls.Label(self, "Bg/TextBPLv")
	self.textPoint = UIControls.Label(self, "Bg/TextBPPoint")
	self.awardData = {}
	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnClick)
	self.btnConfirm:setVisible(false)

	self.panelState = UIControls.Label(self, "Bg/TextState")

	self.panelState:setVisible(false)
end

function BpCell:setCellData(clientData, serverData)
	self.data = clientData
	self.svrData = serverData[clientData.type] or {}

	if Const.REVIEW_VERSION then
		self.textLevel:setText(clientData.desc_name or Lang.get(1203) .. clientData.index)
	else
		self.textLevel:setText(clientData.desc_name or "Lv." .. clientData.index)
	end

	self.textPoint:setText(clientData.param or "")

	if clientData.index == 1 then
		self.slider:setVisible(false)
	else
		self.slider:setVisible(true)
	end

	local state = clientData.state

	self.imgBg:setImage(BG_ImageData.filePath, BG_ImageData.spriteName[state] or BG_ImageData.spriteName[3])
	self.imgLv:setImage(BGLV_ImageData.filePath, BGLV_ImageData.spriteName[state] or BGLV_ImageData.spriteName[3])

	if state == Const.ACT_ACHIEVE_STATE_GOT then
		self.panelState:setVisible(true)
		self.btnConfirm:setVisible(false)
		self.slider:setValue(1)
	elseif state == Const.ACT_ACHIEVE_STATE_ENOUGH then
		self.btnConfirm:setVisible(true)
		self.panelState:setVisible(false)
		self.slider:setValue(1)
	elseif state == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH then
		if self.mParent.curLv == -1 then
			self.slider:setValue(1)
		elseif self.mParent.round + 1 == clientData.index then
			self.slider:setValue(self.mParent.curLv / self.mParent.nextLv)
		else
			self.slider:setValue(0)
		end

		self.btnConfirm:setVisible(false)
		self.panelState:setVisible(false)
	end

	local award = ResRandClient[clientData.award] or {}

	for i, v in ipairs(self.awardData) do
		self.awardData[i]:setVisible(false)
	end

	for i = 1, #award.show_ids do
		if not self.awardData[i] then
			self.awardData[i] = UIControls.getGridAwardContainer(self, "Bg/GridNormalAward")
		end

		self.awardData[i]:setObj(BaseObject.GetObject(award.show_ids[i], award.show_nums[i]))

		self.awardData[i].grid.mDisableWays = true

		self.awardData[i]:setVisible(true)
		self.awardData[i]:setState(nil, state == Const.ACT_ACHIEVE_STATE_GOT, nil)
	end
end

function BpCell:onBtnClick()
	CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.mParent.opId, self.data.index, self.data.type), self.mParent.opId)
end

local BPReturnMainPanel = Class("BPReturnMainPanel", UIControls.Panel)

BPReturnMainPanel.maxShowCount = 5

function BPReturnMainPanel:ctor()
	self.panelLvInfo = UIControls.Panel(self, self.mPath .. "/BgInfo/LvInfo")
	self.txtLevel = UIControls.Label(self, self.mPath .. "/BgInfo/LvInfo/TextLv")
	self.txtPoint = UIControls.Label(self, self.mPath .. "/BgInfo/LvInfo/BPPoint/TextBPPoint")
	self.slider = UIControls.Slider(self, self.mPath .. "/BgInfo/LvInfo/Slider")
	self.panelLvFullInfo = UIControls.Panel(self, self.mPath .. "/BgInfo/LvFullInfo")
	self.panelBPFullPoint = UIControls.Panel(self, self.mPath .. "/BgInfo/LvFullInfo/BPFullPoint")

	self.panelBPFullPoint:setVisible(false)

	self.txtFullPoint = UIControls.Label(self, self.mPath .. "/BgInfo/LvFullInfo/BPFullPoint/TextBPPoint")
	self.btnGift = UIControls.Button(self, self.mPath .. "/BgInfo/BtnGift")

	self.btnGift:addEventClick(self.onGiftClick)

	self.btnFullStore = UIControls.Button(self, self.mPath .. "/BgInfo/BtnFullStore")

	self.btnFullStore:setVisible(false)

	self.txtTalk = UIControls.Label(self, self.mPath .. "/BgTalk/TextTalk")
	self.scrollBPItems = UIControls.ScrollViewLoopV(self, "BPList", 0, self.onBPCellChanged)
end

function BPReturnMainPanel:refreshMainUI()
	local round, curLv, nextLv, overScore = self.mParent:modf()

	self.round = round
	self.curLv = curLv
	self.nextLv = nextLv

	self.txtLevel:setText(round)

	if curLv == -1 and nextLv == -1 then
		self.isFull = true

		self.panelLvInfo:setVisible(false)
		self.panelLvFullInfo:setVisible(true)
		self.btnGift:setVisible(false)
	else
		self.isFull = false

		self.panelLvInfo:setVisible(true)
		self.panelLvFullInfo:setVisible(false)
		self.btnGift:setVisible(true)
		self.txtPoint:setText(utils.format("%1s/%2s", curLv, nextLv))
		self.slider:setValue(curLv / nextLv)
	end

	if self.isFull then
		if overScore then
			self.txtTalk:setText(Lang.get(51406))
		else
			self.txtTalk:setText(Lang.get(51407))
		end
	else
		local freezeTime = tonumber(self.mParent:getFreezeTime())

		if freezeTime > 7 then
			self.txtTalk:setText(Lang.get(51408))
		elseif freezeTime <= 7 then
			self.txtTalk:setText(Lang.get(51409))
		end
	end
end

function BPReturnMainPanel:onSubTabClick(idx)
	self.actData = self.mParent.actObj.actData
	self.clientShowData = self.actData:getActivityClientShowData()
	self.opId = self.mParent.actObj.opId

	self:setJumpIdx()
	self:tryAddFakeAwardData()
	self.scrollBPItems:setTotalCount(#self.clientShowData + 1, self.jumpIdx)
	self:refreshMainUI()
end

function BPReturnMainPanel:tryAddFakeAwardData()
	self.desc = self.actData:getDesc()

	if self.desc and self.desc[self.mParent.actType] then
		local tab = {
			param = "",
			state = 3,
			index = "30+",
			type = 45,
			award = self.desc[self.mParent.actType].convert_rand,
			detail_id = self.mParent.actObj.actId
		}

		self.fakeClientData = tab
	end
end

function BPReturnMainPanel:onBPCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = BpCell(sender, "System/Return/ActivityReturnBPCell", newIdx, 0, 0)
	else
		targetCell.mIndex = newIdx
	end

	targetCell:setCellData(self.clientShowData[newIdx] or self.fakeClientData, self.mParent.serverData)
end

function BPReturnMainPanel:setJumpIdx()
	self.jumpIdx = 0

	for _, clientCell in ipairs(self.clientShowData) do
		local state = self.actData:getAchieveState(clientCell.type, clientCell.index)

		clientCell.state = state
	end

	for _, clientCell in ipairs(self.clientShowData) do
		if clientCell.state == Const.ACT_ACHIEVE_STATE_GOT then
			self.jumpIdx = self.jumpIdx + 1
		else
			self.jumpIdx = self.jumpIdx + 1

			break
		end
	end

	local totalCount = #self.clientShowData

	if totalCount <= self.maxShowCount then
		self.jumpIdx = 1
	elseif totalCount - self.jumpIdx < self.maxShowCount then
		self.jumpIdx = totalCount - self.maxShowCount
	end
end

function BPReturnMainPanel:onGiftClick()
	local actObj = CurAvatar:getActivityObj(9205)

	if self.mParent.actDatas then
		actObj = self.mParent.actDatas[#self.mParent.actDatas]
	end

	if actObj then
		actObj.getBPStoreData = Slot(self.storeLvData, self)

		UIManager.getUI("activitySpeGiftDlg", true):setData(actObj, "activitySpeGiftDlg")
	end
end

function BPReturnMainPanel:storeLvData(addPoint)
	local curPoint = self.mParent.curProgress + (addPoint or 0)
	local preOKData = self.clientShowData[1]

	for _, cellData in ipairs(self.clientShowData) do
		if cellData then
			if curPoint - cellData.param < 0 then
				return self.mParent.clientMaxRound - self.mParent.curProgress, self.mParent.lv, preOKData.desc_name
			else
				preOKData = cellData
			end
		end
	end

	return self.mParent.clientMaxRound - self.mParent.curProgress, self.mParent.lv, -1
end

return BPReturnMainPanel

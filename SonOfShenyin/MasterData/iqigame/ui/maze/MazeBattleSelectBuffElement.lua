-- chunkname: @IQIGame\\UI\\Maze\\MazeBattleSelectBuffElement.lua

local BuffGroupTitleItemView = require("IQIGame.UI.Maze.ItemCell.BuffGroupTitleItemView")
local ItemCell = {}

function ItemCell.New(view, clickHandler)
	local obj = Clone(ItemCell)

	obj:__Init(view, clickHandler)

	return obj
end

function ItemCell:__Init(view, clickHandler)
	self.gameObject = view
	self.clickHandler = clickHandler

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.__delegateOnItemClick()
		if self.clickHandler ~= nil then
			self.clickHandler(self.cfgCid)
			self:Select()
		end
	end

	self.buttonGo:GetComponent("Button").onClick:AddListener(self.__delegateOnItemClick)

	self.buffGroupTitleItemView = BuffGroupTitleItemView.New(self.BuffGroupTitle)
end

function ItemCell:Show(cfgCid)
	self.cfgCid = cfgCid

	local buffItemCfg = CfgLabyrinthBuffPoolTable[self.cfgCid]

	self.buffCid = buffItemCfg.BuffID

	self.gameObject:SetActive(true)
	self:UnSelect()

	local buffCfg = CfgBuffTable[self.buffCid]

	self.nameGo:GetComponent("Text").text = buffCfg.Name

	UGUIUtil.SetText(self.buffDescText, buffCfg.Describe)
	AssetUtil.LoadImage(self, BattleApi:GetAttributeIconUrl(buffCfg.Icon), self.iconGo:GetComponent("Image"))
	AssetUtil.LoadImage(self, MazeApi:GetSelectBuffBackground(buffItemCfg.Quality), self.BgImg:GetComponent("Image"))
	AssetUtil.LoadImage(self, MazeApi:GetSelectBuffFrame(buffItemCfg.Quality), self.iconFrame:GetComponent("Image"))
	self.buffGroupTitleItemView:SetData(self.cfgCid)
end

function ItemCell:Select()
	LuaUtility.SetGameObjectShow(self.SelectImg, true)
end

function ItemCell:UnSelect()
	LuaUtility.SetGameObjectShow(self.SelectImg, false)
end

function ItemCell:Hide()
	self.gameObject:SetActive(false)
end

function ItemCell:Dispose()
	self.buttonGo:GetComponent("Button").onClick:RemoveListener(self.__delegateOnItemClick)
	self.buffGroupTitleItemView:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local Element = {
	itemList = {}
}

function Element.New(view)
	local obj = Clone(Element)

	obj:__Init(view)

	return obj
end

function Element:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	ForTransformChild(self.selectItemRoot.transform, function(_trans, _index)
		local item = ItemCell.New(_trans.gameObject, function(_buffCid)
			self:__OnBuffSelect(_buffCid)
		end)

		table.insert(self.itemList, item)
	end)

	function self.delegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.delegateOnClickBuffListBtn()
		self:OnClickBuffListBtn()
	end

	function self.delegateOnClickRefreshBtn()
		self:OnClickRefreshBtn()
	end

	function self.delegateOnUpdateStageEventLinkResult()
		self:OnUpdateStageEventLinkResult()
	end

	self.confirmBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickConfirmBtn)
	self.buffListBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickBuffListBtn)
	self.refreshBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickRefreshBtn)
end

function Element:Show()
	EventDispatcher.AddEventListener(EventID.OnRefreshBuffResult, self.delegateOnUpdateStageEventLinkResult)
	self.gameObject:SetActive(true)
end

function Element:SetData(stageEventPOD, stageMapPod)
	local stagePod = MazeModule.GetCurStagePOD()
	local stageRoomPod = MazeModule.GetRoomStageMapData(stagePod.curRoomId)
	local buffList = stageRoomPod.eventLinkPod.buffs

	self.stageEventPOD = stageRoomPod.eventLinkPod.stageEvents[stageRoomPod.eventLinkPod.curEventId]
	self.selectCfgCid = nil

	ForArray(buffList, function(_index, _cfgCid)
		local item = self.itemList[_index]

		if item == nil then
			return
		end

		item:Show(_cfgCid)
	end)

	local beginCnt = #buffList + 1

	ForArrayByCount(beginCnt, #self.itemList, 1, function(k)
		self.itemList[k]:Hide()
	end)
	self:RefreshConfirmBtnState()
	self:ShowRefreshInfo()
end

function Element:Hide()
	EventDispatcher.RemoveEventListener(EventID.OnRefreshBuffResult, self.delegateOnUpdateStageEventLinkResult)
	self.gameObject:SetActive(false)
end

function Element:__OnBuffSelect(cfgCid)
	self.selectCfgCid = cfgCid

	ForArray(self.itemList, function(_index, _item)
		_item:UnSelect()
	end)
	self:RefreshConfirmBtnState()
end

function Element:RefreshConfirmBtnState()
	self.confirmBtn:GetComponent("Button").interactable = self.selectCfgCid ~= nil
end

function Element:ShowRefreshInfo()
	local refreshBuffTalentData = MazeModule.GetSenroDataByEffectType(Constant.MazeSenroEffectType.RefreshBuff)

	if refreshBuffTalentData == nil then
		LuaUtility.SetGameObjectShow(self.RefreshParent, false)
	else
		LuaUtility.SetGameObjectShow(self.RefreshParent, true)

		local talentCfg = CfgLabyrinthSenrotalentTable[refreshBuffTalentData.id]
		local mazeStagePod = MazeModule.GetCurStagePOD()
		local surplusCount = talentCfg.TalentParams[refreshBuffTalentData.level][1] - mazeStagePod.buffFreshTime

		UGUIUtil.SetText(self.refreshCountText, string.format("(%s/%s)", surplusCount, talentCfg.TalentParams[refreshBuffTalentData.level][1]))

		self.refreshBtn:GetComponent("Button").interactable = surplusCount > 0
	end
end

function Element:OnUpdateStageEventLinkResult()
	self:SetData()
end

function Element:OnClickConfirmBtn()
	if self.selectCfgCid == nil then
		return
	end

	MazeModule.OnSubmitEvent(self.stageEventPOD.eventId, 0, self.selectCfgCid)
	self:Hide()
end

function Element:OnClickBuffListBtn()
	EventDispatcher.Dispatch(EventID.OpenMazeBuffListUI)
end

function Element:OnClickRefreshBtn()
	MazeModule.OnRefreshBuff()
end

function Element:Dispose()
	self.confirmBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickConfirmBtn)
	self.buffListBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickBuffListBtn)
	self.refreshBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickRefreshBtn)
	EventDispatcher.RemoveEventListener(EventID.OnRefreshBuffResult, self.delegateOnUpdateStageEventLinkResult)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return Element

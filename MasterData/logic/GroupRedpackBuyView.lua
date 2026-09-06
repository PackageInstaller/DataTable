-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupredpack/view/GroupRedpackBuyView.lua

module("logic.extensions.groupredpack.view.GroupRedpackBuyView", package.seeall)

local GroupRedpackBuyView = class("GroupRedpackBuyView", ViewComponent)

function GroupRedpackBuyView:ctor()
	GroupRedpackBuyView.super.ctor(self)
end

function GroupRedpackBuyView:unbindEvents()
	GroupRedpackBuyView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnSelect)
	GameUtil.rmClickHandler(self._btnRandom)
	self._dropdown:RemoveOnValueChanged()
end

function GroupRedpackBuyView:bindEvents()
	GroupRedpackBuyView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnSelect, self._onClickSelect, self)
	GameUtil.addClickHandler(self._btnRandom, self._onClickRandom, self)
	self._dropdown:AddOnValueChanged(self._onValueChanged, self)
end

function GroupRedpackBuyView:buildUI()
	GroupRedpackBuyView.super.buildUI(self)

	self._btnClose = self:getBtn("viewBgGo/canelBtn")
	self._btnSure = self:getBtn("viewBgGo/sureBtn")
	self._btnSelect = self:getBtn("viewBgGo/selectBtn")
	self._btnRandom = self:getBtn("viewBgGo/slogan/btnRandom")
	self._dropdown = DropDownAdapter.Get(self:getGo("viewBgGo/type/dropdown_filter"))
	self._rewardCon = self:getGo("viewBgGo/reward/container")
	self._txtRedpackNum = self:getTxt("viewBgGo/num/txtNum")
	self._txtMoney = self:getTxt("viewBgGo/money/txtNum")
	self._txtSlogan = self:getTxt("viewBgGo/slogan/txtSlogan")
	self._petCon = self:getGo("viewBgGo/pet")
end

function GroupRedpackBuyView:onExit()
	GroupRedpackBuyView.super.onExit(self)
	uGuiUtil.clearImage(self._petCon)
	MaterialMgr.resetAll(self._rewardCon)
	GlobalDispatcher:removeListener(GlobalNotify.GroupRedPackSelectCover, self._refreshCover, self)
end

function GroupRedpackBuyView:onEnter()
	GroupRedpackBuyView.super.onEnter(self)

	local params = self:getOpenParam()

	self._redpackType = params[1]
	self._activityId = GroupRedpackModel.instance:getActivityId()
	self._cfgs = GroupRedpackConfig.instance:getGroupRedpackCfgsByActId(self._activityId)
	self._curSloganId = 1
	self._groupId = GroupRedpackModel.instance:getGroupId()

	self:_initPreSelect()
	self._dropdown:ClearOptions()

	local redpackCfgs = GroupRedpackConfig.instance:getGroupRedpackPlanCfgs(self._cfgs.redPackPlanId)

	for i, value in ipairs(redpackCfgs) do
		self._dropdown:AddOptions(value.name)
	end

	self._dropdown:SetValue(self._redpackType - 1)
	GlobalDispatcher:addListener(GlobalNotify.GroupRedPackSelectCover, self._refreshCover, self)
	self:_refreshView()
end

function GroupRedpackBuyView:_initPreSelect()
	local prePetId = GroupRedpackModel.instance:getPrePetIdCache()

	if not string.nilorempty(prePetId) then
		self._curPetId = prePetId
	else
		local coverCfg = GroupRedpackConfig.instance:getGroupRedpackCoverCfgsById(self._cfgs.coverPlanId, self._groupId)
		local coverIds = string.split(coverCfg.coverIds, ";")

		self._curPetId = coverIds[1]
	end
end

function GroupRedpackBuyView:_refreshView()
	local redpackCfg = GroupRedpackConfig.instance:getGroupRedpackPlanCfgsById(self._cfgs.redPackPlanId, self._redpackType)
	local type, id, num = MaterialMgr.getMatParams(redpackCfg.sendItem)
	local proxyArr = MaterialMgr.setCellListByCfg(redpackCfg.senderPrize, self._rewardCon)
	local name = MaterialMgr.getMaterialsName(MatType.PET_SKIN, self._curPetId)

	self._txtRedpackNum.text = string.format("<color=#cbfeff>%s</color>个", redpackCfg.redPackCount)
	self._txtMoney.text = num

	local richTextName = string.format("<color=#cbfeff>%s</color>", name)
	local randomSlogan = self:_getRandomSlogan()

	randomSlogan = string.gsub(randomSlogan, "{amount}", num)
	randomSlogan = string.gsub(randomSlogan, "{count}", redpackCfg.redPackCount)
	randomSlogan = string.gsub(randomSlogan, "{faceName}", richTextName)
	self._txtSlogan.text = randomSlogan

	local petCo = CharacterConfig.instance:getModelCo(checknumber(self._curPetId))

	uGuiUtil.setSpriteToImage(self._petCon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(petCo.cardName))
end

function GroupRedpackBuyView:_refreshCover(id)
	self._curPetId = id

	self:_refreshView()
end

function GroupRedpackBuyView:_getRandomSlogan()
	local maxNum = GroupRedpackConfig.instance:getGroupRedpackSloganNum(self._cfgs.sloganPlanId)

	self._curSloganId = math.random(1, maxNum)

	local templateId = GroupRedpackConfig.instance:getGroupRedpackSloganCfgsById(self._cfgs.sloganPlanId, self._curSloganId).templateId

	return ChatConfig.instance:getSystemMsgT(templateId).template
end

function GroupRedpackBuyView:_onClickClose()
	self:close()
end

function GroupRedpackBuyView:_onClickSure()
	local redpackCfg = GroupRedpackConfig.instance:getGroupRedpackPlanCfgsById(self._cfgs.redPackPlanId, self._redpackType)
	local type, id, num = MaterialMgr.getMatParams(redpackCfg.cost)
	local costName = MaterialMgr.getMaterialsNameByCfg(redpackCfg.cost)
	local content = string.format("确定要花费%s%s，发送%s个指定金额红包吗？", costName, num, redpackCfg.redPackCount)

	TipsFacade.instance:openPopupCostMatViewNew(type, id, num, content, function()
		GroupRedpackController.instance:sendGroupRedPackSendReq(self._activityId, self._redpackType, self._curPetId, self._curSloganId)
		GroupRedpackModel.instance:setPrePetIdCache(self._curPetId)
		self:close()
	end)
end

function GroupRedpackBuyView:_onClickSelect()
	UIStateManager.instance:push(ViewName.GroupRedpackSelectView, self._curPetId)
end

function GroupRedpackBuyView:_onClickRandom()
	self:_refreshView()
end

function GroupRedpackBuyView:_onValueChanged(value)
	self._redpackType = value + 1

	self:_refreshView()
end

return GroupRedpackBuyView

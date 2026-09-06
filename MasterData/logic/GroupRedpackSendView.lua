-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupredpack/view/GroupRedpackSendView.lua

module("logic.extensions.groupredpack.view.GroupRedpackSendView", package.seeall)

local GroupRedpackSendView = class("GroupRedpackSendView", ViewComponent)

function GroupRedpackSendView:ctor()
	GroupRedpackSendView.super.ctor(self)
end

function GroupRedpackSendView:unbindEvents()
	GroupRedpackSendView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnLeft)
	GameUtil.rmClickHandler(self._btnRight)
	GameUtil.rmClickHandler(self._btnTips)
end

function GroupRedpackSendView:bindEvents()
	GroupRedpackSendView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTips, self._onClickTips, self)
	GameUtil.addClickHandler(self._btnLeft, GameUtil.handler(self._onClickSwitchPet, self, true))
	GameUtil.addClickHandler(self._btnRight, GameUtil.handler(self._onClickSwitchPet, self, false))
end

function GroupRedpackSendView:buildUI()
	GroupRedpackSendView.super.buildUI(self)

	self._btnClose = self:getBtn("container/leftTop/btnClose")
	self._btnTips = self:getBtn("container/btnHelp")
	self._txtTime = self:getTxt("container/timeTips/txt")
	self._rare = self:getGo("petInfo/rare")
	self._txtName = self:getTxt("petInfo/txtName")
	self._txtBubble = self:getTxt("petInfo/tip/txtDesc")
	self._petCon = self:getGo("petCard/pet/petIcon")
	self._btnLeft = self:getBtn("btn_left")
	self._btnRight = self:getBtn("btn_right")
	self._tableview = self:getGo("container/mid/tableview")
	self._tablecell = self:getGo("container/mid/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function GroupRedpackSendView:onExit()
	GroupRedpackSendView.super.onExit(self)
	removetimer(self._tickSpine, self)

	if self._advertisementTween then
		self._advertisementTween:Kill(false)

		self._advertisementTween = nil
	end

	uGuiUtil.clearImage(self._petCon)
	MaterialMgr.resetAll(self._txtBubble)
	GlobalDispatcher:removeListener(GlobalNotify.GroupRedPackGetInfoRes, self._refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.GroupRedPackSendRes, self._gainPrize, self)
end

function GroupRedpackSendView:onEnter()
	GroupRedpackSendView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]

	self:_initView()

	self._cfgs = GroupRedpackConfig.instance:getGroupRedpackCfgsByActId(self._activityId)
	self._groupId = GroupRedpackModel.instance:getGroupId()
	self._curIndex = 1

	self:_playPetSpine()
	GlobalDispatcher:addListener(GlobalNotify.GroupRedPackGetInfoRes, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.GroupRedPackSendRes, self._gainPrize, self)
	GroupRedpackController.instance:sendGroupRedPackGetInfoReq(self._activityId)
	settimer(5, self._tickSpine, self)
end

function GroupRedpackSendView:_initView()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.GROUP_RED_PACK, self._activityId)
	local startDate, endDate = os.date("*t", startTime), os.date("*t", endTime)

	if self._txtTime then
		self._txtTime.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
	end
end

function GroupRedpackSendView:_refreshView()
	local cfg = GroupRedpackConfig.instance:getGroupRedpackPlanCfgs(self._cfgs.redPackPlanId)

	self._scrollList:reloadData(cfg)
end

function GroupRedpackSendView:_updateCell(view, goCell, data, tag)
	local cell = self:_clearCell(goCell)
	local cfg = GroupRedpackConfig.instance:getGroupRedpackPlanCfgsById(self._cfgs.redPackPlanId, data.type)
	local type, id, num = MaterialMgr.getMatParams(cfg.sendItem)
	local countList = GroupRedpackModel.instance:getCountList()
	local remainNum = checknumber(cfg.dailySendLimit - countList[data.type].todaySendTimes)
	local proxyArr = MaterialMgr.setCellListByCfg(cfg.senderPrize, cell.goItemCon)

	cell.txtTitle.text = cfg.name
	cell.txtGet.text = num
	cell.txtRedpackNum.text = cfg.redPackCount
	cell.txtCount.text = string.format("%s/%s", remainNum, cfg.dailySendLimit)

	for k, v in pairs(proxyArr) do
		GameUtil.setLocalScale(v.view, 0.6, 0.6, 0.6)
	end

	local imgPath = string.split(cfg.imgPath, "#")
	local img = imgPath[3]

	uGuiUtil.setSpriteToImage(cell.goRedpack, uGuiUtil.SpriteType.BigBg, GameUrl.getGoddessRedpackUrl(img))
	GameUtil.addClickHandler(cell.goRedpack, GameUtil.handler(self._onClickSendRedpack, self, data.type, remainNum))

	local isRed = data.type <= 3 and 0 or 1

	GameUtil.setUITextColorIdx(cell.colorChangeTitle, isRed and 0 or 1)
	GameUtil.setUITextColorIdx(cell.txtRedpackNum, isRed and 0 or 1)
	GameUtil.setUITextColorIdx(cell.txtGet, isRed and 0 or 1)
end

function GroupRedpackSendView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.txtTitle = goutil.findChildTextComponent(goCell, "container/redPack/title/txtTitle")
	cell.colorChangeTitle = goutil.findChild(goCell, "container/redPack/title")
	cell.txtGet = goutil.findChildTextComponent(goCell, "container/redPack/get/txtGet")
	cell.txtRedpackNum = goutil.findChildTextComponent(goCell, "container/redPack/redpackNum/txtNum")
	cell.txtCount = goutil.findChildTextComponent(goCell, "container/redPack/count/txtCount")
	cell.goItemCon = goutil.findChild(goCell, "container/redPack/itemCon")
	cell.goRedpack = goutil.findChild(goCell, "container/redPack")

	MaterialMgr.resetAll(cell.goItemCon)
	uGuiUtil.clearImage(cell.goRedpack)
	GameUtil.rmClickHandler(cell.goRedpack)

	return cell
end

function GroupRedpackSendView:_playPetSpine()
	local bubbleNum = GroupRedpackConfig.instance:getGroupRedpackBubbleNum()
	local cfgs = GroupRedpackConfig.instance:getGroupRedpackCoverCfgsById(self._cfgs.coverPlanId, self._groupId)
	local petIds = string.split(cfgs.coverIds, ";")
	local petId = checknumber(petIds[self._curIndex])
	local petCo = CharacterConfig.instance:getModelCo(petId)

	uGuiUtil.setSpriteToImage(self._petCon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(petCo.cardName))

	self._txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, petId)
	self._txtBubble.text = GroupRedpackConfig.instance:getGroupRedpackBubbleCfgs(math.random(1, bubbleNum)).des
end

function GroupRedpackSendView:_tickSpine()
	self:_onClickSwitchPet(false)
end

function GroupRedpackSendView:_gainPrize(changeSetId, prizeStrList)
	MaterialController.instance:showChangeSetInTemp(changeSetId)
end

function GroupRedpackSendView:_onClickClose()
	self:close()
end

function GroupRedpackSendView:_onClickSendRedpack(id, remainNum)
	if remainNum > 0 then
		UIStateManager.instance:push(ViewName.GroupRedpackBuyView, id)
	else
		FloatWordMgr.instance:show("本红包的发放次数已达到上限，明天再来吧")
	end
end

function GroupRedpackSendView:_onClickSwitchPet(isLeft)
	if isLeft then
		self._curIndex = self._curIndex - 1 or self._curIndex + 1
	end

	local len = GroupRedpackConfig.instance:getGroupRedpackPetLen(self._cfgs.coverPlanId, self._groupId)

	if len < self._curIndex then
		self._curIndex = 1
	elseif self._curIndex <= 0 then
		self._curIndex = len
	end

	local image = self._petCon:GetComponent("Image")
	local sequence = DG.Tweening.DOTween.Sequence()
	local twenner = image:DOFade(0, 0.5):SetEase(DG.Tweening.Ease.InQuart)

	local function startHandler()
		self:_playPetSpine()
		Game.ImageUtil.SetImageAlpha(image, 0)
	end

	local twenner2 = image:DOFade(1, 0.5):SetEase(DG.Tweening.Ease.InQuart):OnStart(startHandler)

	sequence:Append(twenner)
	sequence:Append(twenner2)

	self._advertisementTween = sequence
end

function GroupRedpackSendView:_onClickTips()
	UIStateManager.instance:open(ViewName.RulesView, "groupredpack_rule")
end

return GroupRedpackSendView

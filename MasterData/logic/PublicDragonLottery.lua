-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/publiccardpool/PublicDragonLottery.lua

module("logic.extensions.lottery.view.publiccardpool.PublicDragonLottery", package.seeall)

local PublicDragonLottery = class("PublicDragonLottery", LotteryModleView)

function PublicDragonLottery:buildUI()
	PublicDragonLottery.super.buildUI(self)

	self._lotteryTxt = self:getTxt("viewDownGo/lotteryBtn/text")
	self._wishTxt = self:getTxt("viewDownGo/wishBtn/Text")
	self._rankTxt = self:getTxt("viewDownGo/rankBtn/Text")
	self._bubbleTxt = self:getTxt("viewDownGo/bubble/txtDesc")
	self._lotteryIconTxt = self:getTxt("viewDownGo/cycleTip/cycleDesIma")
	self._longyanGo = self:getGo("longyanGo")
	self._wishBtnGo = self:getGo("viewDownGo/wishBtn")
	self._bubbleGo = self:getGo("viewDownGo/bubble")
end

function PublicDragonLottery:onEnter()
	local params = self:getOpenParam()

	self._planCfg = DragonConfig.instance:getPlanCfgById(params[1], params[2])
	self._curActId = self._planCfg.activityId
	self._curDragonType = self._planCfg.poolGroupId

	local actCfg = DragonConfig.instance:getActivityCfg(self._curActId)

	if actCfg == nil then
		printError("liubc---召唤卡池      PublicDragonLottery:onEnter()    获取配置为空！")
		self:close()

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.UpdataDragonInfo, self._updateLotteryShow, self)
	self:_overWriteOnEnter(actCfg)
	self:_refreshCfgUI()
end

function PublicDragonLottery:onExit()
	PublicDragonLottery.super.onExit(self)
	uGuiUtil.clearImage(self._longyanGo)
end

function PublicDragonLottery:_overWriteOnEnter(actCfg)
	self._poolCfg = DragonConfig.instance:getDragonPoolCfg(actCfg.poolGroupId)

	MaterialMgr.updateItemByStr(self._countImaGo, self._poolCfg.lotteryCost, self._countTxt)

	self._petNameTxt.text = MaterialMgr.getMaterialsName(MatType.Pet, self._poolCfg.raceId)

	if self._poolCfg and not string.nilorempty(self._poolCfg.goodItems) then
		local goodsList = string.split(self._poolCfg.goodItems, "#")

		for i = 1, #goodsList do
			if goodsList[i] and not string.nilorempty(goodsList[i]) and self._middleItemList[i] then
				GameUtil.SetActive(self._middleItemList[i].itemGo, true)
				MaterialMgr.updateItemByStr(self._middleItemList[i].equipImaGo, goodsList[i])
			end
		end
	end

	local isHaveTask = not string.nilorempty(self._poolCfg.jumpItem)

	GameUtil.SetActive(self._taskNode, isHaveTask)

	if isHaveTask then
		local list = string.split(self._poolCfg.jumpItem, "#")

		if list and list[1] and self._taskGoods1 then
			MaterialMgr.setCellByCfg(list[1], self._taskGoods1)
		end

		if list and list[2] and self._taskGoods2 then
			MaterialMgr.setCellByCfg(list[2], self._taskGoods2)
		end

		self._taskShopTxt.text = lang("text_dragon_desc_14")
	end

	self:_updateLotteryShow()
	DragonController.instance:csGodLotteryGetInfoReq(self._curActId, self._curDragonType)
	uGuiUtil.setSpriteToImage(self._viewBgImg, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/%s", self._poolCfg.viewBg))

	local objList = {
		{
			id = "204:2",
			showAdd = true
		},
		{
			showAdd = true,
			id = self._poolCfg.lotteryCost
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)

	local isShowWish = false

	if not ActivityDefineController.instance:isTimeGateProcessType(self._curActId) then
		self._openTime.text = self._poolCfg.timeDesc
		isShowWish = true
	else
		self._openTime.text = TimeGateController.instance:getActTimeShow(self._curActId)
		isShowWish = true
	end

	isShowWish = isShowWish and not string.nilorempty(self._poolCfg.jumpToShop)

	goutil.setActive(self._wishBtnGo, isShowWish)
	goutil.setActive(self._bubbleGo, isShowWish)

	if GameUtil.getUserDayData("PublicDragonLotteryView" .. self._curActId) == nil then
		GameUtil.saveUserDayData("PublicDragonLotteryView" .. self._curActId, 1)
	end
end

function PublicDragonLottery:_refreshCfgUI()
	self._lotteryTxt.text = self._planCfg.buttonName
	self._wishTxt.text = self._planCfg.shopDesc
	self._rankTxt.text = self._planCfg.rankName
	self._bubbleTxt.text = self._planCfg.shopTag
	self._lotteryIconTxt.text = self._planCfg.petImg

	uGuiUtil.setSpriteToImage(self._longyanGo, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/zhaohuan/%s.png", self._planCfg.welfareImg))
end

return PublicDragonLottery

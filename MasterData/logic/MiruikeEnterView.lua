-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miruikeintroduce/view/MiruikeEnterView.lua

module("logic.extensions.miruikeintroduce.view.MiruikeEnterView", package.seeall)

local MiruikeEnterView = class("MiruikeEnterView", ViewComponent)

function MiruikeEnterView:ctor()
	MiruikeEnterView.super.ctor(self)
end

function MiruikeEnterView:unbindEvents()
	MiruikeEnterView.super.unbindEvents(self)
	self:_removeListeners()
end

function MiruikeEnterView:bindEvents()
	MiruikeEnterView.super.bindEvents(self)
	self:_addLiteners()
end

function MiruikeEnterView:buildUI()
	MiruikeEnterView.super.buildUI(self)

	self._txtTime = self:getTxt("time/txtTime")
	self._btnTip = self:getBtn("btnTip")
	self._btnClose = self:getBtn("btnClose")
	self._btnTrial = self:getBtn("info/btnTrial")
	self._txtTip = goutil.findChildTextComponent(self.mainGO, "info/tip/txt")
	self._txtIntroduceTitle = goutil.findChildTextComponent(self.mainGO, "info/txtTitle")
	self._txtIntroduce = goutil.findChildTextComponent(self.mainGO, "info/txtDesc")
	self._allPetItemList = {}

	for i = 1, 2 do
		local petItemGo = goutil.findChild(self.mainGO, string.format("con%d", i))
		local item = {}

		item.btnJump = goutil.findChild(petItemGo, "btnJump")
		item.txt = goutil.findChildTextComponent(petItemGo, "btnJump/desc/txt")
		item.rareGo = goutil.findChild(petItemGo, "petInfo/rareGo")
		item.petNameTxt = goutil.findChildTextComponent(petItemGo, "petInfo/petNameTxt")
		item.introduceBtn = goutil.findChild(petItemGo, "petInfo/introduceBtn")
		item.skillBtn = goutil.findChild(petItemGo, "petInfo/skillBtn")

		table.insert(self._allPetItemList, item)
	end

	self._activityId = checkint(MiruikeIntroduceConfig.instance:getCommonValue("MAIN_ACT_ID"))
end

function MiruikeEnterView:onExit()
	MiruikeEnterView.super.onExit(self)
	removetimer(self._onTick, self)
end

function MiruikeEnterView:onEnter()
	MiruikeEnterView.super.onEnter(self)

	local _, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.WelfareSummary, self._activityId)

	self._destTime = endTime

	settimer(1, self._onTick, self)
	self:_onTick()
	self:_updatePets()

	self._txtTip.text = MiruikeIntroduceConfig.instance:getCommonValue("ENTER_TIP")
	self._txtIntroduceTitle.text = MiruikeIntroduceConfig.instance:getCommonValue("ENTER_INTRODUCE_TITLE")
	self._txtIntroduce.text = MiruikeIntroduceConfig.instance:getCommonValue("ENTER_INTRODUCE")
end

function MiruikeEnterView:_removeListeners()
	self._btnTip:RemoveClickListener()
	self._btnTrial:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnClose)

	for i = 1, 2 do
		local petItem = self._allPetItemList[i]

		GameUtil.rmClickHandler(petItem.introduceBtn)
		GameUtil.rmClickHandler(petItem.skillBtn)
		GameUtil.rmClickHandler(petItem.btnJump)
	end
end

function MiruikeEnterView:_addLiteners()
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnTrial:AddClickListener(self._onClickTrial, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)

	for i = 1, 2 do
		local petItem = self._allPetItemList[i]

		GameUtil.addClickHandler(petItem.introduceBtn, GameUtil.handler(self._onClickIntroduce, self, i))
		GameUtil.addClickHandler(petItem.skillBtn, GameUtil.handler(self._onClickSkill, self, i))
		GameUtil.addClickHandler(petItem.btnJump, GameUtil.handler(self._onClickJump, self, i))
	end
end

function MiruikeEnterView:_onTick()
	self._leftTime = self._destTime - ServerTime.nowServerLook()

	if self._leftTime > 0 then
		self._txtTime.text = self._leftTime > 86400 and string.format("时间剩余：%s", GameUtil.FormatTimeWordsNoSec(self._leftTime)) or string.format("时间剩余：%s", GameUtil.FormatTimeWords(self._leftTime))
	else
		self:_actEndOp()
	end
end

function MiruikeEnterView:_actEndOp()
	self._txtTime.text = "活动已结束"

	removetimer(self._updateTimer, self)
end

function MiruikeEnterView:_updatePets()
	for i = 1, 2 do
		local enterConf = MiruikeIntroduceConfig.instance:getEnterConfigByIndex(i)
		local receId = enterConf.raceId
		local petItem = self._allPetItemList[i]

		petItem.petNameTxt.text = MaterialMgr.getMaterialsName(MatType.Pet, receId)

		MaterialMgr.setCell(MatType.Rare, receId, petItem.rareGo)

		petItem.txt.text = enterConf.desc
	end
end

function MiruikeEnterView:_onClickIntroduce(index)
	local receId = MiruikeIntroduceConfig.instance:getEnterConfigByIndex(index).raceId

	if receId then
		PetbookController.instance:openPetinfoView(receId)
	end
end

function MiruikeEnterView:_onClickSkill(index)
	local receId = MiruikeIntroduceConfig.instance:getEnterConfigByIndex(index).raceId

	if receId then
		BattleFacade.instance:sendPreviewPetBattle(receId, receId)
	end
end

function MiruikeEnterView:_onClickJump(index)
	local conf = MiruikeIntroduceConfig.instance:getEnterConfigByIndex(index)

	if conf then
		GotoMgr.gotoByString(conf.jumpTo)
	end
end

function MiruikeEnterView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "newProfessionPsychicHUD_rule")
end

function MiruikeEnterView:_onClickTrial()
	UIStateManager.instance:push(ViewName.PetcollegeView, 36)
end

return MiruikeEnterView

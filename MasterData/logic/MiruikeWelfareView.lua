-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miruikeintroduce/view/MiruikeWelfareView.lua

module("logic.extensions.miruikeintroduce.view.MiruikeWelfareView", package.seeall)

local MiruikeWelfareView = class("MiruikeWelfareView", ViewComponent)

function MiruikeWelfareView:ctor()
	MiruikeWelfareView.super.ctor(self)
end

function MiruikeWelfareView:unbindEvents()
	MiruikeWelfareView.super.unbindEvents(self)
	self:_removeListeners()
end

function MiruikeWelfareView:bindEvents()
	MiruikeWelfareView.super.bindEvents(self)
	self:_addLiteners()
end

function MiruikeWelfareView:buildUI()
	MiruikeWelfareView.super.buildUI(self)

	self._btnInfo = self:getBtn("btnInfo")
	self._btnSkill = self:getBtn("btnSkill")
	self._raceId = checkint(MiruikeIntroduceConfig.instance:getCommonValue("WELFARE_RACE_ID"))
	self._listBtnJumps = {}
	self._listTxtDescs = {}
	self._listTxtNames = {}

	for i = 1, 2 do
		table.insert(self._listBtnJumps, self:getBtn(string.format("con%d/btnJump", i)))
		table.insert(self._listTxtDescs, self:getTxt(string.format("con%d/btnJump/txtDesc", i)))
		table.insert(self._listTxtNames, self:getTxt(string.format("con%d/btnJump/txtName", i)))
	end

	self._txtName = self:getTxt("petInfo/txtName")
	self._rareGo = self:getGo("petInfo/rareGo")
	self._lihui = self:getGo("mid/rolePoint")
	self._petPhoto = PetPhotoShow.Get(self._lihui)
end

function MiruikeWelfareView:onExit()
	MiruikeWelfareView.super.onExit(self)
	self._petPhoto:clear()
end

function MiruikeWelfareView:onEnter()
	MiruikeWelfareView.super.onEnter(self)

	for i = 1, 2 do
		local conf = MiruikeIntroduceConfig.instance:getJumpConf(i)

		self._listTxtDescs[i].text = conf.desc
		self._listTxtNames[i].text = conf.title
	end

	self._txtName.text = MaterialMgr.getMaterialsName(MatType.Pet, self._raceId)

	MaterialMgr.setCell(MatType.Rare, self._raceId, self._rareGo)

	local modelCo = CharacterConfig.instance:getModelUIPosAndScale("handbook", tonumber(self._raceId))
	local x, y, scale = modelCo[1], modelCo[2], modelCo[3]

	self._petPhoto:showPetEffect(self._raceId, true, 4, "handbook")
end

function MiruikeWelfareView:_removeListeners()
	self._btnInfo:RemoveClickListener()
	self._btnSkill:RemoveClickListener()

	for _, btn in ipairs(self._listBtnJumps) do
		GameUtil.rmClickHandler(btn)
	end
end

function MiruikeWelfareView:_addLiteners()
	self._btnInfo:AddClickListener(self._onClickbtnInfo, self)
	self._btnSkill:AddClickListener(self._onClickbtnSkill, self)

	for i, btn in ipairs(self._listBtnJumps) do
		GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickJump, self, i))
	end
end

function MiruikeWelfareView:_onClickbtnInfo()
	if self._raceId then
		PetbookController.instance:openPetinfoView(self._raceId)
	end
end

function MiruikeWelfareView:_onClickbtnSkill()
	if self._raceId then
		BattleFacade.instance:sendPreviewPetBattle(self._raceId, self._raceId)
	end
end

function MiruikeWelfareView:_onClickJump(index)
	if index == 1 then
		SurveyController.instance:reportBehavior(200924)

		return MiruikeTipsView.showInternal()
	elseif index == 2 then
		SurveyController.instance:reportBehavior(200925)
	end

	local conf = MiruikeIntroduceConfig.instance:getJumpConf(index)

	if conf then
		GotoMgr.gotoByString(conf.jumpTo)
	end
end

return MiruikeWelfareView

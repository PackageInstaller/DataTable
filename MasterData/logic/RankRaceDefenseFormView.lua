-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceDefenseFormView.lua

module("logic.extensions.rankrace.view.RankRaceDefenseFormView", package.seeall)

local RankRaceDefenseFormView = class("RankRaceDefenseFormView", FormationView)

function RankRaceDefenseFormView:buildUI()
	RankRaceDefenseFormView.super.buildUI(self)
	self:_initBuffNode()

	self._formationNode = self:getGo("Nego_Left/SelectView/Viewport/Content/Nego_Select/Btn_Formation")

	self._formationNode:SetActive(false)
	goutil.setActive(self._btnShare.gameObject, false)
	self._btnSingleLine:Layout()
end

function RankRaceDefenseFormView:_initBuffNode()
	local parentNode = self:getGo("Nego_Left")
	local res = rescache:GetResourceNoLoadIfNotExists("ui/views/rankrace/rankracefmtbuffs.prefab")
	local mainAsset = res:GetMainAsset()

	self._buffGo = goutil.cloneAndSetParent(mainAsset, parentNode.transform, "BuffNode")

	local btnDefenseBuff = goutil.findChild(self._buffGo, "BtnDefenseBuff")

	self._btnDefenseBuf = Framework.UIClickTrigger.Get(btnDefenseBuff)
	self._imgBuffIconState = btnDefenseBuff:GetComponent(typeof(UIImageSpriteChange))
	self._imgBuffIcon = goutil.findChild(btnDefenseBuff, "Icon")
	self._tipsPos = goutil.findChild(btnDefenseBuff, "TipsPos")
	self._buffName = goutil.findChildTextComponent(btnDefenseBuff, "TxtBuffName")

	Framework.TransformUtil.SetAnchoredPos(self._buffGo.transform, 69.5, 10)
end

function RankRaceDefenseFormView:bindEvents()
	RankRaceDefenseFormView.super.bindEvents(self)
	self._btnDefenseBuf:AddClickListener(self._onClickDefenseBuf, self)
end

function RankRaceDefenseFormView:unbindEvents()
	RankRaceDefenseFormView.super.unbindEvents(self)
	self._btnDefenseBuf:RemoveClickListener()
end

function RankRaceDefenseFormView:onEnter()
	self._titleTxt1.text = "守 阵"
	self._matchType = self:getFirstParam()

	self._tipObj.gameObject:SetActive(true)
	self._formationNode:SetActive(false)

	self._tipObj.text = "在排位赛中以此防守阵型应战"

	self:_updateBuff()
end

function RankRaceDefenseFormView:onExit()
	local bigImg = Framework.ImageBigBG.Get(self._imgBuffIcon)

	bigImg:ClearImage()

	self._matchType = nil

	RankRaceDefenseFormView.super.onExit(self)
end

function RankRaceDefenseFormView:_onClickRecFormation()
	local matchType = self._matchType

	function FuncOpenController.instance.onRecomentSelCallback(fightCreepsCfgs)
		RankRaceDefenseFastFormation.instance:clean()

		for i = 1, #fightCreepsCfgs do
			local raceId = fightCreepsCfgs[i].raceId
			local petId = BagModel.instance:getPetIdByRaceId(raceId)

			if petId ~= nil then
				local posId = fightCreepsCfgs[i].posId

				RankRaceFmtModel.instance:changePosition(matchType, posId, petId)
			end
		end

		RankRaceFmtModel.instance:saveCurrFormation(matchType)
	end

	UIStateManager.instance:push(ViewName.PetNoticeView, 5)
end

function RankRaceDefenseFormView:_updateBuff()
	local buffId = RankRaceFmtModel.instance:getDefenseBuffId(self._matchType)
	local buffCo = RankRaceConfig.instance:getRankRaceBuffCo(buffId)

	if buffId then
		self._imgBuffIcon:SetActive(buffId > 0)
	end

	if buffCo then
		self._buffName.text = buffCo.name

		self._imgBuffIconState:ChangeStateNow(0)
		uGuiUtil.setSpriteToImage(self._imgBuffIcon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getRankRaceBuffIconUrl(buffCo.icon))
	else
		self._buffName.text = "防守之力"

		self._imgBuffIconState:ChangeStateNow(1)
	end
end

function RankRaceDefenseFormView:_onClickDefenseBuf()
	local buffId = RankRaceFmtModel.instance:getDefenseBuffId(self._matchType)

	ViewMgr.instance:open(ViewName.RankRaceBuffTipsView, buffId, self._tipsPos, self._matchType)
end

function RankRaceDefenseFormView:_onClickSave()
	if RankRaceFmtModel.instance:isCurDefFormationEmpty(self._matchType) then
		FloatWordMgr.instance:show("防守阵容不能为空")

		return
	end

	RankRaceFmtModel.instance:saveCurrFormation(self._matchType)
	self:close()
end

function RankRaceDefenseFormView:_onClickClose()
	RankRaceFmtModel.instance:resetCurrFormation(self._matchType)
	RankRaceController.instance:setCloseForReset(true)
	self:close()
end

return RankRaceDefenseFormView

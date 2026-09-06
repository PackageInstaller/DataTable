-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerreturn/view/PlayerReturnLetterView.lua

module("logic.extensions.playerreturn.view.PlayerReturnLetterView", package.seeall)

local PlayerReturnLetterView = class("PlayerReturnLetterView", ViewComponent)

function PlayerReturnLetterView:ctor()
	PlayerReturnLetterView.super.ctor(self)
end

function PlayerReturnLetterView:bindEvents()
	PlayerReturnLetterView.super.bindEvents(self)
	GameUtil.asBtn(self._viewClickGo):AddClickListener(self._onClickViewBtn, self)
	GameUtil.asBtn(self._openBtnGo):AddClickListener(self._onClickOpenBtn, self)
end

function PlayerReturnLetterView:unbindEvents()
	PlayerReturnLetterView.super.unbindEvents(self)
	GameUtil.asBtn(self._viewClickGo):RemoveClickListener()
	GameUtil.asBtn(self._openBtnGo):RemoveClickListener()
end

function PlayerReturnLetterView:onExit()
	PlayerReturnLetterView.super.onExit(self)
	removetimer(self._calculationSurplusTimeOpen, self)
	removetimer(self._calculationSurplusTimeEnd, self)

	self._isOpenLetter = false

	if self._curShowSpine then
		self._curShowSpine:stop()
	end

	goutil.destroy(self._spineAnimGo)

	self._spineAnimGo = nil
	self._curShowSpine = nil
	self._curShowAnim = nil

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)

		self._pmEff = nil
	end

	if self._btnEff then
		UIEffectManager.instance:stopEffect(self._btnEff)

		self._btnEff = nil
	end

	if self._endEff then
		UIEffectManager.instance:stopEffect(self._endEff)

		self._endEff = nil
	end
end

function PlayerReturnLetterView:destroyUI()
	PlayerReturnLetterView.super.destroyUI(self)
end

function PlayerReturnLetterView:buildUI()
	PlayerReturnLetterView.super.buildUI(self)

	self._viewClickGo = self:getGo("viewClickGo")
	self._openBtnGo = self:getGo("openBtnGo")
	self._canvas = goutil.findChildComponent(self.mainGO, "canvasGo", "Canvas")
	self._openTxt = goutil.findChildTextComponent(self._canvas.gameObject, "openTxt")
	self._openImaGo = goutil.findChild(self._canvas.gameObject, "openImaGo")
	self._openTxt.text = ""

	self._openImaGo:SetActive(false)
end

function PlayerReturnLetterView:onEnter()
	PlayerReturnLetterView.super.onEnter(self)
	removetimer(self._calculationSurplusTimeOpen, self)
	removetimer(self._calculationSurplusTimeEnd, self)

	self._isOpenLetter = false
	self._openTxt.text = ""

	self._openImaGo:SetActive(false)
	self._openBtnGo:SetActive(true)

	self._spineAnimGo = self:getResInstance("effect/prefabs/ui/fx_ui_30tianhuigui/spine/fx_ui_xingfeng.prefab")

	goutil.addChildToParent(self._spineAnimGo, self.mainGO)

	self._curShowAnim = self._spineAnimGo:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

	local mesh = self._curShowAnim.gameObject:GetComponent(typeof(UnityEngine.MeshRenderer))
	local sortOrder = UGUIToolHelper.GetNodeCanvansSortingOrder(self.mainGO)

	mesh.sortingOrder = sortOrder + 1
	self._canvas.sortingOrder = sortOrder + 2
	self._curShowSpine = StorySpinePlayer.New()

	self._curShowSpine:setSpine(self._curShowAnim, {
		"idle"
	})

	local effPath = "fx_ui_30tianhuigui/fx_ui_30_caidai.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)

	effPath = "fx_ui_30tianhuigui/fx_ui_30_shaoguang.prefab"
	self._btnEff = UIEffectManager.instance:playEffect(self, "fx_ui_30tianhuigui/fx_ui_30_shaoguang.prefab", self._openBtnGo, 0, 0, true, nil, nil, nil, self)

	self._btnEff:setParent(self._openBtnGo.transform)
	self._btnEff:setLocalPos(0, -4.5, 0)
	self._btnEff:setScale(1)
end

function PlayerReturnLetterView:_onClickOpenBtn()
	if self._btnEff then
		UIEffectManager.instance:stopEffect(self._btnEff)

		self._btnEff = nil
	end

	if self._curShowSpine then
		self._curShowSpine:setSpine(self._curShowAnim, {
			"open",
			"stop"
		})
	end

	local effPath = "fx_ui_30tianhuigui/fx_ui_30_dianji.prefab"
	local sgEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, false, nil, nil, nil, self)

	sgEff:setParent(self.mainGO.transform)
	sgEff:setLocalPos(0, 0, 0)
	sgEff:setScale(1)
	settimer(1, self._calculationSurplusTimeOpen, self, false)
	self._openBtnGo:SetActive(false)
	PlayerReturnModel.instance:setOpenActivityPopup()
end

function PlayerReturnLetterView:_calculationSurplusTimeOpen()
	removetimer(self._calculationSurplusTimeOpen, self)

	self._isOpenLetter = true

	self._openImaGo:SetActive(true)

	local actiInfo = PlayerReturnModel.instance:getOpenActivityInfo()

	if actiInfo then
		if not actiInfo.actId then
			local actId = 1
			local actCfg = PlayerReturnConfig.instance:getReturnActivityCfg(actId)

			if actCfg and not string.nilorempty(actCfg.letter) then
				self._openTxt.text = actCfg.letter
			end
		end
	end
end

function PlayerReturnLetterView:_onClickViewBtn()
	if not self._isOpenLetter then
		return
	end

	self._isOpenLetter = false

	self._openImaGo:SetActive(false)

	self._openTxt.text = ""

	if self._curShowSpine then
		self._curShowSpine:setSpine(self._curShowAnim, {
			"end"
		})
	end

	settimer(0.4, self._calculationSurplusTimeEnd, self, false)

	local effPath = "fx_ui_30tianhuigui/fx_ui_30_end.prefab"

	self._endEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, false, nil, nil, nil, self)

	self._endEff:setParent(self.mainGO.transform)
	self._endEff:setLocalPos(0, 0, 0)
	self._endEff:setScale(1)
end

function PlayerReturnLetterView:_calculationSurplusTimeEnd()
	removetimer(self._calculationSurplusTimeEnd, self)

	if self._endEff then
		UIEffectManager.instance:stopEffect(self._endEff)

		self._endEff = nil
	end

	UIStateManager.instance:push(ViewName.PlayerReturn)
	self:close()
end

return PlayerReturnLetterView

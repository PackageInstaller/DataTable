-- chunkname: @modules/logic/versionactivity3_6/yami/view/game/V3a6YaMiEvaluationView.lua

module("modules.logic.versionactivity3_6.yami.view.game.V3a6YaMiEvaluationView", package.seeall)

local V3a6YaMiEvaluationView = class("V3a6YaMiEvaluationView", BaseView)

function V3a6YaMiEvaluationView:onInitView()
	self._simagecurrentproducts = gohelper.findChildSingleImage(self.viewGO, "root/middle/Att/#simage_currentproducts")
	self._imagelevel = gohelper.findChildImage(self.viewGO, "root/middle/#simage_level")
	self._txtnum1 = gohelper.findChildText(self.viewGO, "root/bg1/#txt_num")
	self._txtnum2 = gohelper.findChildText(self.viewGO, "root/bg2/#txt_num")
	self._txtnum3 = gohelper.findChildText(self.viewGO, "root/bg3/#txt_num")
	self._txtrank = gohelper.findChildText(self.viewGO, "root/txt_title")
	self._gomask = gohelper.findChild(self.viewGO, "root/mask")
	self._btnmask = gohelper.getClick(self._gomask)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6YaMiEvaluationView:addEvents()
	self._btnmask:AddClickListener(self._onClickMask, self)
end

function V3a6YaMiEvaluationView:removeEvents()
	self._btnmask:RemoveClickListener()
end

function V3a6YaMiEvaluationView:_onClickMask()
	self._showIndex = self._showIndex - 1

	if self._showIndex < 0 then
		self:_onReturnMainView()

		return
	end

	if self._showIndex == 0 then
		self:_showFinishProduct()

		return
	end

	self:_showRankProduct()
end

function V3a6YaMiEvaluationView:_onReturnMainView()
	V3a6YaMiController.instance:dispatchEvent(V3a6YaMiEvent.onReturnMainView)
	V3a6YaMiController.instance:openMainView(true)
	self:closeThis()
end

function V3a6YaMiEvaluationView:_editableInitView()
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	local attrRoot = gohelper.findChild(self.viewGO, "root/middle")

	self._attrPanel = MonoHelper.addNoUpdateLuaComOnceToGo(attrRoot, V3a6YaMiAttrPanel)
	self._goBouns1 = gohelper.findChild(self.viewGO, "root/bg1")
	self._goBouns2 = gohelper.findChild(self.viewGO, "root/bg2")
	self._goBouns3 = gohelper.findChild(self.viewGO, "root/bg3")
end

function V3a6YaMiEvaluationView:_refreshProduct(productMo)
	AudioMgr.instance:trigger(AudioEnum3_6.YaMi.play_ui_renmen_waiwei_tan)

	if productMo then
		self._anim:Play("switch", 0, 0)
		self._attrPanel:onRefresh(productMo:getAttrMo(), false)

		local ratingCo = V3a6YaMiConfig.instance:getRatingCo(productMo.rating)

		if ratingCo and not string.nilorempty(ratingCo.icon) then
			UISpriteSetMgr.instance:setV3a6YaMiSprite(self._imagelevel, ratingCo.icon)
		end

		local icon = ResUrl.getV3a6YaMiItemSingleBg(productMo.co.icon)

		self._simagecurrentproducts:LoadImage(icon)
	end
end

function V3a6YaMiEvaluationView:_refreshRank(isFinish, rank, aiIndex)
	local productMo = self._productMos[rank]
	local productName = productMo.co.name
	local name, lang

	if isFinish then
		local lang = "v3a6_yami_result_rank"

		self._txtrank.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang(lang), rank, productName)
	else
		local lang = "v3a6_yami_result_rank" .. rank
		local name

		if aiIndex == 0 then
			name = luaLang("v3a6_yami_researcher")
			self._selfRank = rank
		else
			name = self._aiConfig["name" .. aiIndex]
		end

		self._txtrank.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang(lang), name, productName)
	end
end

function V3a6YaMiEvaluationView:_refreshBouns()
	local exp, money = V3a6YaMiModel.instance:getResearchResult()

	self._txtnum1.text = string.format("+%s", money)
	self._txtnum2.text = string.format("+%s", exp)

	self:_setActiveBouns(true)
end

function V3a6YaMiEvaluationView:_setActiveBouns(isActive)
	gohelper.setActive(self._goBouns1, isActive)
	gohelper.setActive(self._goBouns2, isActive)

	local addMission = V3a6YaMiModel.instance:getAddMissionCurrency()

	if isActive and addMission > 0 then
		self._txtnum3.text = string.format("+%s", addMission)
	end

	gohelper.setActive(self._goBouns3, isActive and addMission > 0)
end

function V3a6YaMiEvaluationView:onUpdateParam()
	return
end

function V3a6YaMiEvaluationView:onOpen()
	local level, infos = V3a6YaMiModel.instance:getEvaluateHerosInfos()

	self._productMos = infos
	self._aiConfig = V3a6YaMiConfig.instance:getAICo(level or 1)
	self._showIndex = 4

	TaskDispatcher.cancelTask(self._showMask, self)
	self:_showRankProduct()
end

function V3a6YaMiEvaluationView:_showRankProduct()
	local productMo = self._productMos[self._showIndex]

	self:_refreshProduct(productMo)
	self:_setActiveBouns(false)
	self:_refreshRank(false, self._showIndex, productMo.aiIndex)
end

function V3a6YaMiEvaluationView:_showFinishProduct()
	gohelper.setActive(self._gomask, false)

	local productMo = self._productMos[self._selfRank]

	self._anim:Play("open", 0, 0)
	TaskDispatcher.runDelay(self._showMask, self, 1)
	self:_refreshProduct(productMo)
	self:_refreshBouns()
	self:_refreshRank(true, self._selfRank)
end

function V3a6YaMiEvaluationView:_showMask()
	gohelper.setActive(self._gomask, true)
end

function V3a6YaMiEvaluationView:onClose()
	TaskDispatcher.cancelTask(self._showMask, self)
end

function V3a6YaMiEvaluationView:onDestroyView()
	self._simagecurrentproducts:UnLoadImage()
end

return V3a6YaMiEvaluationView

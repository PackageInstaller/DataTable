-- chunkname: @modules/logic/fight/view/preview/SkillEditorToolsBtnView.lua

module("modules.logic.fight.view.preview.SkillEditorToolsBtnView", package.seeall)

local SkillEditorToolsBtnView = class("SkillEditorToolsBtnView", BaseViewExtended)

function SkillEditorToolsBtnView:onInitView()
	self._btntools = gohelper.findChildButton(self.viewGO, "right/btn_tools")
	self._toolsBtnList = gohelper.findChild(self.viewGO, "right/go_tool_btn_list")
	self._btnModel = gohelper.findChildButton(self.viewGO, "right/go_tool_btn_list/btn_model")
	self._gotoolroot = gohelper.findChild(self.viewGO, "go_tool_root")
	self._gotoolviewmodel = gohelper.findChild(self.viewGO, "go_tool_root/go_tool_view_model")
	self._btnText = gohelper.findChildText(self.viewGO, "right/btn_tools/Text")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SkillEditorToolsBtnView:addEvents()
	self._btntools:AddClickListener(self._onBtnTools, self)
end

function SkillEditorToolsBtnView:removeEvents()
	self._btntools:RemoveClickListener()

	if self._btns then
		for _, btn in ipairs(self._btns) do
			btn:RemoveClickListener()
		end

		self._btns = nil
	end
end

function SkillEditorToolsBtnView:_editableInitView()
	self:addToolBtn("改伤害", self._onClickDamage)
	self:addToolBtn("角色描边", self._onClickOutline)
	self:addToolBtn("开启出牌镜头", self._onClickPlayCardCameraAni)
	self:addToolBtn("移除术阵特效", self._onClickSuZhenSwitch)
	self:addToolBtn("诺蒂卡衔接测试", self._onClickNuoDiKaXianJie)
end

function SkillEditorToolsBtnView:_onClickNuoDiKaXianJie()
	ViewMgr.instance:openView(ViewName.GMFightNuoDiKaXianJieCeShi)
end

function SkillEditorToolsBtnView:_onClickDamage()
	local inputMo = CommonInputMO.New()

	inputMo.title = "请输入伤害数值"

	local customDamage = SkillEditorStepBuilder.customDamage
	local defaultDamage = SkillEditorStepBuilder.defaultDamage

	inputMo.defaultInput = customDamage and customDamage > 0 and customDamage or defaultDamage

	function inputMo.sureCallback(inputStr)
		GameFacade.closeInputBox()

		local inputNum = tonumber(inputStr)

		if inputNum and inputNum > 0 then
			GameFacade.showToast(ToastEnum.IconId, "伤害调整为 " .. inputStr)

			SkillEditorStepBuilder.customDamage = inputNum
		elseif string.nilorempty(inputStr) then
			SkillEditorStepBuilder.customDamage = nil
		end
	end

	GameFacade.openInputBox(inputMo)
end

function SkillEditorToolsBtnView:_onClickOutline()
	SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr.OnClickOutline)
end

function SkillEditorToolsBtnView:_onClickPlayCardCameraAni(text)
	self._playCardCameraAniPlaying = not self._playCardCameraAniPlaying
	text.text = self._playCardCameraAniPlaying and "关闭出牌镜头" or "开启出牌镜头"

	FightController.instance:dispatchEvent(FightEvent.SkillEditorPlayCardCameraAni, self._playCardCameraAniPlaying)
end

function SkillEditorToolsBtnView:_onClickSuZhenSwitch()
	local magicCircleInfo = FightModel.instance:getMagicCircleInfo()

	if magicCircleInfo then
		local entity = FightHelper.getEntity(FightEntityScene.MySideId)

		if entity then
			local config = lua_magic_circle.configDict[magicCircleInfo.magicCircleId]

			if config then
				entity.effect:removeEffectByEffectName(config.loopEffect)
			end
		end
	end
end

function SkillEditorToolsBtnView:addToolBtn(name, clickFun, class)
	local goBtn = gohelper.cloneInPlace(self._btnModel.gameObject, name)

	gohelper.setActive(goBtn, true)

	local btn = gohelper.getClick(goBtn)
	local txt = gohelper.findChildText(goBtn, "Text")

	btn:AddClickListener(clickFun, class or self, txt)

	txt.text = name
	self._btns = self._btns or {}

	table.insert(self._btns, btn)

	return goBtn
end

function SkillEditorToolsBtnView:addToolViewObj(name)
	return (gohelper.cloneInPlace(self._gotoolviewmodel, name))
end

function SkillEditorToolsBtnView:onRefreshViewParam()
	return
end

function SkillEditorToolsBtnView:_onBtnTools()
	self._listState = not self._listState

	gohelper.setActive(self._toolsBtnList, self._listState)

	self._btnText.text = self._listState and "close" or "tools"

	local childCount = self._gotoolroot.transform.childCount

	for i = 0, childCount - 1 do
		local obj = self._gotoolroot.transform:GetChild(i).gameObject

		gohelper.setActive(obj, false)
	end
end

function SkillEditorToolsBtnView:hideToolsBtnList()
	gohelper.setActive(self._toolsBtnList, false)
end

function SkillEditorToolsBtnView:onOpen()
	self._listState = true

	self:_onBtnTools()
	self:openSubView(SkillEditorToolsChangeVariant, self.viewGO)
	self:openSubView(SkillEditorToolsChangeQuality, self.viewGO)
end

function SkillEditorToolsBtnView:onClose()
	return
end

function SkillEditorToolsBtnView:onDestroyView()
	return
end

return SkillEditorToolsBtnView

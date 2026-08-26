-- chunkname: @modules/logic/survival/view/shelter/SurvivalDiffTempTab.lua

module("modules.logic.survival.view.shelter.SurvivalDiffTempTab", package.seeall)

local SurvivalDiffTempTab = class("SurvivalDiffTempTab", SimpleListItem)

function SurvivalDiffTempTab:onInit()
	self.image_DifficultyIcon = gohelper.findChildImage(self.viewGO, "image_DifficultyIcon")
	self.select = gohelper.findChild(self.viewGO, "bg/selected")
	self.btnConfirm = gohelper.findChildButtonWithAudio(self.viewGO, "go_confirm")
	self.unselect = gohelper.findChild(self.viewGO, "bg/unselect")
	self.go_use = gohelper.findChild(self.viewGO, "textTitle/go_use")
	self.textTitle = gohelper.findChildTextMesh(self.viewGO, "textTitle")
	self.txt_rate = gohelper.findChildTextMesh(self.viewGO, "txt_rate")
	self.go_lock = gohelper.findChild(self.viewGO, "go_lock")
	self.anim_go_lock = self.go_lock:GetComponent(gohelper.Type_Animator)

	gohelper.setActive(self.select, false)
	gohelper.setActive(self.btnConfirm.gameObject, false)
	gohelper.setActive(self.unselect, true)
end

function SurvivalDiffTempTab:onAddListeners()
	self.addClickCb(self, self.btnConfirm, self.onClickBtnConfirm, self)
end

function SurvivalDiffTempTab:onRemoveListeners()
	return
end

function SurvivalDiffTempTab:onClickBtnConfirm()
	if self.onClickDiffTempBtnConfirm then
		self.onClickDiffTempBtnConfirm(self.context, self)
	end
end

function SurvivalDiffTempTab:onItemShow(data)
	self.id = data.id
	self.onClickDiffTempBtnConfirm = data.onClickDiffTempBtnConfirm
	self.context = data.context
	self.cfg = lua_survival_hardness_mod.configDict[self.id]
	self.title = self.cfg.name

	local assess = SurvivalDifficultyModel.instance:getDifficultyAssessByCustomTempDiff(self.itemIndex)

	self.txt_rate.text = luaLang("multiple") .. assess

	local info = SurvivalModel.instance:getOutSideInfo()

	self.isUnlock = info:isUnlockDifficultyMod(self.id)

	local color = self.image_DifficultyIcon.color

	if self.isUnlock then
		self.textTitle.alpha = 1
		self.image_DifficultyIcon.color = Color.New(color.r, color.g, color.b, 1)
	else
		self.textTitle.alpha = 0.4
		self.image_DifficultyIcon.color = Color.New(color.r, color.g, color.b, 0.4)
	end

	self.textTitle.text = self.cfg.name

	self:refresh()
end

function SurvivalDiffTempTab:onSelectChange(isSelect)
	gohelper.setActive(self.select, isSelect)
	gohelper.setActive(self.btnConfirm.gameObject, isSelect)
	gohelper.setActive(self.unselect, not isSelect)
end

function SurvivalDiffTempTab:refresh()
	local selectIndex2 = SurvivalDifficultyModel.instance:getCustomFragmentSelect()

	gohelper.setActive(self.go_use, selectIndex2 == self.itemIndex)
	gohelper.setActive(self.go_lock, not self.isUnlock)
end

function SurvivalDiffTempTab:playAnim()
	if self.id == SurvivalConst.CustomDifficulty then
		return
	end

	local isNew = SurvivalDifficultyModel.instance:isNewDiff(self.id)

	if isNew then
		gohelper.setActive(self.go_lock, true)
		self.anim_go_lock:Play("unlock", 0, 0)
	end
end

return SurvivalDiffTempTab

-- chunkname: @modules/logic/rouge2/bossbattle/view/Rouge2_SaveInfoActiveSkillComp.lua

module("modules.logic.rouge2.bossbattle.view.Rouge2_SaveInfoActiveSkillComp", package.seeall)

local Rouge2_SaveInfoActiveSkillComp = class("Rouge2_SaveInfoActiveSkillComp", LuaCompBase)

function Rouge2_SaveInfoActiveSkillComp.Get(go, uiType)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, Rouge2_SaveInfoActiveSkillComp, uiType)
end

function Rouge2_SaveInfoActiveSkillComp:ctor(uiType)
	self._uiType = uiType
	self._spacing = 0
	self._systemParamMap = {}
end

function Rouge2_SaveInfoActiveSkillComp:init(go)
	self.go = go
	self._isInitDone = false
	self._hasData = false
	self._loader = PrefabInstantiate.Create(self.go)

	self._loader:startLoad(Rouge2_Enum.ResPath.SaveInfoActiveSkillComp, self._onLoadDone, self)
end

function Rouge2_SaveInfoActiveSkillComp:_onLoadDone(loader)
	self:initSkillList(loader:getInstGO())

	self._isInitDone = true

	self:refreshUI()
end

function Rouge2_SaveInfoActiveSkillComp:initSkillList(goSkill)
	self._goSkill = goSkill
	self._goRoot = gohelper.findChild(self._goSkill, "#go_Root")
	self._scrollActiveSkill = gohelper.findChild(self._goSkill, "#go_Root/#scroll_ActiveSkill"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self._goSkillContent = gohelper.findChild(self._goSkill, "#go_Root/#scroll_ActiveSkill/Viewport/Content")
	self._goSkillItem = gohelper.findChild(self._goSkill, "#go_Root/#scroll_ActiveSkill/Viewport/Content/#go_SkillItem")
	self._layoutGroup = gohelper.onceAddComponent(self._goSkillContent, gohelper.Type_HorizontalLayoutGroup)
end

function Rouge2_SaveInfoActiveSkillComp:onUpdateMO(dataType, dataIdList)
	self._dataType = dataType
	self._dataIdList = dataIdList

	if dataIdList then
		self._skillNum = #dataIdList or 0
	end

	self._hasSkill = self._skillNum and self._skillNum > 0
	self._hasData = true

	self:refreshUI()
end

function Rouge2_SaveInfoActiveSkillComp:refreshUI()
	if not self._isInitDone or not self._hasData then
		return
	end

	if self._hasSkill then
		gohelper.CreateObjList(self, self._refreshSkillItem, self._dataIdList, self._goSkillContent, self._goSkillItem)
	else
		gohelper.CreateNumObjList(self._goSkillContent, self._goSkillItem, Rouge2_Enum.MaxActiveSkillNum, self._refreshEmptySkillItem, self)
	end

	self._layoutGroup.spacing = self._spacing
end

function Rouge2_SaveInfoActiveSkillComp:_refreshSkillItem(goSkill, skillId, index)
	local goRoot = gohelper.findChild(goSkill, "go_Root")
	local skillIconItem = Rouge2_CommonSkillIconItem.Get(goRoot, self._uiType)

	if self._systemParamMap then
		for key, value in pairs(self._systemParamMap) do
			skillIconItem:updateSystemParam(key, value)
		end
	end

	skillIconItem:onUpdateMO(self._dataType, skillId)
end

function Rouge2_SaveInfoActiveSkillComp:_refreshEmptySkillItem(goSkill, index)
	self:_refreshSkillItem(goSkill, nil, index)
end

function Rouge2_SaveInfoActiveSkillComp:setLayoutSpacing(spacing)
	spacing = spacing or 0

	if self._spacing == spacing then
		return
	end

	self._spacing = spacing

	self:refreshUI()
end

function Rouge2_SaveInfoActiveSkillComp:updateSystemParam(key, value)
	local originValue = self._systemParamMap[key]

	if originValue == value then
		return
	end

	self._systemParamMap[key] = value

	self:refreshUI()
end

function Rouge2_SaveInfoActiveSkillComp:setParentScroll(goParentScroll)
	self._scrollActiveSkill.parentGameObject = goParentScroll
end

return Rouge2_SaveInfoActiveSkillComp

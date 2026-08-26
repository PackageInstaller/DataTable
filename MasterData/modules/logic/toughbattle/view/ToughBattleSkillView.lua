-- chunkname: @modules/logic/toughbattle/view/ToughBattleSkillView.lua

module("modules.logic.toughbattle.view.ToughBattleSkillView", package.seeall)

local ToughBattleSkillView = class("ToughBattleSkillView", BaseView)

function ToughBattleSkillView:onInitView()
	self._simgrole = gohelper.findChildSingleImage(self.viewGO, "root/view/role/#simage_role")
	self._txttitle = gohelper.findChildTextMesh(self.viewGO, "root/view/title/titletxt")
	self._txtskilldes = gohelper.findChildTextMesh(self.viewGO, "root/view/#txt_desc")
	self._txtnormaldes = gohelper.findChildTextMesh(self.viewGO, "root/view/#txt_desc/#txt_desc2")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/view/#btn_closebtn")
	self._goBuffContainer = gohelper.findChild(self.viewGO, "root/#go_buffContainer")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ToughBattleSkillView:addEvents()
	self._btnclose:AddClickListener(self.closeThis, self)
end

function ToughBattleSkillView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function ToughBattleSkillView:_editableInitView()
	gohelper.setActive(self._goBuffContainer, false)
end

function ToughBattleSkillView:onOpen()
	self:refreshSkillInfo(self.viewParam.showCo)

	if self.viewParam.isShowList then
		self:createAndSelect()
	end
end

function ToughBattleSkillView:createAndSelect()
	local go = self:getResInst(self.viewContainer._viewSetting.otherRes.rolelist, self.viewGO, "rolelist")
	local comp = MonoHelper.addNoUpdateLuaComOnceToGo(go, ToughBattleRoleListComp, self.viewParam)

	comp:setClickCallBack(self.onRoleSelect, self)

	self._roleList = comp

	comp:setSelect(self.viewParam.showCo)
end

function ToughBattleSkillView:onRoleSelect(co)
	self:refreshSkillInfo(co)
	self._roleList:setSelect(co)
end

function ToughBattleSkillView:refreshSkillInfo(co)
	self._simgrole:LoadImage("singlebg/toughbattle_singlebg/role/rolehalfpic" .. co.sort .. ".png")

	local heroCo = lua_siege_battle_hero.configDict[co.heroId]

	if not heroCo then
		logError("no hero co" .. co.heroId)
	else
		self._txttitle.text = heroCo.name
		self._txtskilldes.text = heroCo.desc
	end

	self._txtnormaldes.text = co.instructionDesc
end

function ToughBattleSkillView:onClickModalMask()
	self:closeThis()
end

function ToughBattleSkillView:onDestroyView()
	self._simgrole:UnLoadImage()
end

return ToughBattleSkillView

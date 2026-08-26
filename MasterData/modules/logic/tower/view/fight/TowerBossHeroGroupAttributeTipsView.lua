-- chunkname: @modules/logic/tower/view/fight/TowerBossHeroGroupAttributeTipsView.lua

module("modules.logic.tower.view.fight.TowerBossHeroGroupAttributeTipsView", package.seeall)

local TowerBossHeroGroupAttributeTipsView = class("TowerBossHeroGroupAttributeTipsView", BaseView)

function TowerBossHeroGroupAttributeTipsView:onInitView()
	self.gotipitem = gohelper.findChild(self.viewGO, "mask/root/scrollview/viewport/content/tipitem")

	gohelper.setActive(self.gotipitem, false)

	self.items = {}
	self.txtTeamLev = gohelper.findChildTextMesh(self.viewGO, "title/txt_Lv/num")
	self._btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "title/Click")
	self.goSmallTips = gohelper.findChild(self.viewGO, "#go_SmallTips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerBossHeroGroupAttributeTipsView:addEvents()
	self.addClickCb(self, self._btnClick, self.onBtnClick, self)
end

function TowerBossHeroGroupAttributeTipsView:removeEvents()
	self:removeClickCb(self._btnClick)
end

function TowerBossHeroGroupAttributeTipsView:_editableInitView()
	return
end

function TowerBossHeroGroupAttributeTipsView:onBtnClick()
	self._isSmallTipsShow = not self._isSmallTipsShow

	gohelper.setActive(self.goSmallTips, self._isSmallTipsShow)
end

function TowerBossHeroGroupAttributeTipsView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function TowerBossHeroGroupAttributeTipsView:onOpen()
	self:refreshParam()
	self:refreshView()
end

function TowerBossHeroGroupAttributeTipsView:refreshParam()
	self.bossId = self.viewParam.bossId
	self.bossMo = TowerAssistBossModel.instance:getById(self.bossId)
	self.config = TowerConfig.instance:getAssistBossConfig(self.bossId)
end

function TowerBossHeroGroupAttributeTipsView:refreshView()
	self:refreshAttr()
end

function TowerBossHeroGroupAttributeTipsView:refreshAttr()
	local teamLev = HeroSingleGroupModel.instance:getTeamLevel()

	self.txtTeamLev.text = HeroConfig.instance:getCommonLevelDisplay(teamLev)

	if self.bossMo and self.bossMo.trialLevel > 0 then
		local var_10_0 = self.bossMo.trialLevel

		if not self.bossMo.trialLevel then
			if self.bossMo then
				var_10_0 = self.bossMo.level

				if not self.bossMo.level then
					local bossLev = 1
					local list = TowerConfig.instance:getHeroGroupAddAttr(self.bossId, teamLev, bossLev)
					local max = math.max(#list, #self.items)

					for i = 1, max do
						local item = self:getAttrItem(i)

						self:updateAttrItem(item, list[i])
					end
				end
			end
		end
	end
end

function TowerBossHeroGroupAttributeTipsView:getAttrItem(index)
	if not self.items[index] then
		local item = self:getUserDataTb_()

		item.go = gohelper.cloneInPlace(self.gotipitem)
		item.imgIcon = gohelper.findChildImage(item.go, "icon")
		item.txtName = gohelper.findChildTextMesh(item.go, "name")
		item.txtNum = gohelper.findChildTextMesh(item.go, "num")
		item.txtAdd = gohelper.findChildTextMesh(item.go, "add")
		self.items[index] = item
	end

	return self.items[index]
end

function TowerBossHeroGroupAttributeTipsView:updateAttrItem(item, data)
	if not data then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	local co = HeroConfig.instance:getHeroAttributeCO(data.key)

	item.txtName.text = co.name

	if not data.val then
		item.txtNum.text = data.upAttr and string.format("%s%%", data.val * 0.1) or string.format("%s", data.val)
		item.txtAdd.text = string.format("+%s%%", data.add * 0.1)

		UISpriteSetMgr.instance:setCommonSprite(item.imgIcon, string.format("icon_att_%s", data.key))
	end
end

function TowerBossHeroGroupAttributeTipsView:onClose()
	return
end

function TowerBossHeroGroupAttributeTipsView:onDestroyView()
	return
end

return TowerBossHeroGroupAttributeTipsView

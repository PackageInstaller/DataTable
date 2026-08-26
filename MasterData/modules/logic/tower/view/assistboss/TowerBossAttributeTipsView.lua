-- chunkname: @modules/logic/tower/view/assistboss/TowerBossAttributeTipsView.lua

module("modules.logic.tower.view.assistboss.TowerBossAttributeTipsView", package.seeall)

local TowerBossAttributeTipsView = class("TowerBossAttributeTipsView", BaseView)

function TowerBossAttributeTipsView:onInitView()
	self.gotipitem = gohelper.findChild(self.viewGO, "mask/root/scrollview/viewport/content/tipitem")

	gohelper.setActive(self.gotipitem, false)

	self.items = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerBossAttributeTipsView:addEvents()
	return
end

function TowerBossAttributeTipsView:removeEvents()
	return
end

function TowerBossAttributeTipsView:_editableInitView()
	return
end

function TowerBossAttributeTipsView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function TowerBossAttributeTipsView:onOpen()
	self:refreshParam()
	self:refreshView()
end

function TowerBossAttributeTipsView:refreshParam()
	self.bossId = self.viewParam.bossId
	self.isFromHeroGroup = self.viewParam.isFromHeroGroup
	self.bossMo = TowerAssistBossModel.instance:getById(self.bossId)
	self.config = TowerConfig.instance:getAssistBossConfig(self.bossId)
end

function TowerBossAttributeTipsView:refreshView()
	self:refreshAttr()
end

function TowerBossAttributeTipsView:refreshAttr()
	local teamLev = 0

	if self.bossMo and self.bossMo.trialLevel > 0 then
		local var_9_0 = self.bossMo.trialLevel

		if not self.bossMo.trialLevel then
			if self.bossMo then
				var_9_0 = self.bossMo.level

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

function TowerBossAttributeTipsView:getAttrItem(index)
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

function TowerBossAttributeTipsView:updateAttrItem(item, data)
	if not data then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	local co = HeroConfig.instance:getHeroAttributeCO(data.key)

	item.txtName.text = co.name
	item.txtNum.text = data.val and (data.upAttr and string.format("%s%%", data.val * 0.1) or string.format("%s", data.val)) or ""
	item.txtAdd.text = string.format("+%s%%", data.add * 0.1)

	UISpriteSetMgr.instance:setCommonSprite(item.imgIcon, string.format("icon_att_%s", data.key))
end

function TowerBossAttributeTipsView:onClose()
	return
end

function TowerBossAttributeTipsView:onDestroyView()
	return
end

return TowerBossAttributeTipsView

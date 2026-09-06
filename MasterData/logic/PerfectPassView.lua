-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotcopy/view/PerfectPassView.lua

module("logic.extensions.plotcopy.view.PerfectPassView", package.seeall)

local PerfectPassView = class("PerfectPassView", ViewComponent)

function PerfectPassView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._item = self:getGo("item")
	self._txtDesc = self:getTxt("txtDesc")
	self._roleModel = self:getGo("roleModel")
	self._contentGo = self:getGo("scroll/viewport/content")

	self._item:SetActive(false)
end

function PerfectPassView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function PerfectPassView:unbindEvents()
	self._closeButton:RemoveClickListener()
end

function PerfectPassView:onEnter()
	local param = self:getOpenParam()
	local chapterId = param[1]
	local stageId = param[2]
	local cfg = CopyConfig.instance:getStageById(chapterId, stageId)

	if cfg then
		self:_showItems(cfg.perfectPassMp)

		num = checknumber(string.split(cfg.perfectPassCondition, "$")[2])
		self._txtDesc.text = string.format("完美通关：阵亡精灵不超过%d个", num)
	end

	self._roleModel.transform.localScale = Vector3.New(-1, 1, 1)

	self:_showRoleModel()
end

function PerfectPassView:onExit()
	self:_removeItems()
	self:_resetRoleModel()
end

function PerfectPassView:_showRoleModel()
	local raceId = 10278
	local cfg = CharacterConfig.instance:getPetCo(raceId)
	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(raceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = 0.3
	end

	self:_resetRoleModel()

	local callback

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, cfg.faceIds, self._roleModel, scale, nil, nil, x, y)
end

function PerfectPassView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function PerfectPassView:_onClickClose()
	self:close()
end

function PerfectPassView:_showItems(rewardStr)
	self:_removeItems()

	rewardStr = MaterialMgr.changeItemStr(rewardStr)

	local list = string.split(rewardStr, "#")

	if list then
		if not #list then
			local count = 0

			if count > 0 then
				self._itemGoList = {}

				for i, v in ipairs(list) do
					local go = goutil.cloneAndSetParent(self._item, self._contentGo.transform, "item" .. i)

					go:SetActive(true)
					MaterialMgr.setCellByCfg(v, go)
					table.insert(self._itemGoList, go)
				end
			end
		end
	end
end

function PerfectPassView:_removeItems()
	if self._itemGoList then
		for i, go in ipairs(self._itemGoList) do
			MaterialMgr.resetAll(go)
		end

		self._itemGoList = nil
	end

	goutil.clearChildren(self._contentGo)
end

return PerfectPassView

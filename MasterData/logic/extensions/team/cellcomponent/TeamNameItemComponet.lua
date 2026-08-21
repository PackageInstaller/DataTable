-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/team/cellcomponent/TeamNameItemComponet.lua

module("logic.extensions.team.cellcomponent.TeamNameItemComponet", package.seeall)

local ButtonAdapter = Astral.ButtonAdapter
local M = class("TeamNameItemComponet")
local UnLockTipModule = CommEnum.UnLockTipModule

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:Awake()
	local registry = self._viewElementsRegistry

	self._teamNameText = registry:findUIElement("team_name_item_1308557416", UIComponentType.Text)
	self._teamNameText2 = registry:findUIElement("team_name_item_1221308484", UIComponentType.Text)
	self._btnSelect = ButtonAdapter.Get(registry:findUIElement("team_name_item_970533225"))
	self._btnChangeName = ButtonAdapter.Get(registry:findUIElement("team_name_item_2093132128"))
	self._btnNormal = ButtonAdapter.Get(registry:findUIElement("team_name_item_1508699203"))
	self._btnUnlock = ButtonAdapter.Get(registry:findUIElement("team_name_item_536441802"))

	self._btnSelect:AddClickListener(self._clickSelect, self)
	self._btnChangeName:AddClickListener(self._clickChangeName, self)
	self._btnNormal:AddClickListener(self._clickNormal, self)
	self._btnUnlock:AddClickListener(self._clickUnLock, self)
end

function M:setCellData(data, index)
	self._data = data
	self._index = index

	self:setContentText(data)
end

function M:setClickTeam(func, handler)
	self._clickCallBackFunc = func
	self._clickCallBackHandler = handler
end

function M:setContentText(itemInfo)
	self._teamNameText.text = itemInfo.name
	self._teamNameText2.text = itemInfo.name

	if not itemInfo.unlock then
		goutil.setActive(self._btnSelect.gameObject, false)
	end

	goutil.setActive(self._btnNormal.gameObject, itemInfo.unlock)
	goutil.setActive(self._btnUnlock.gameObject, not itemInfo.unlock)
end

function M:setSelectState(isSelect)
	goutil.setActive(self._btnSelect.gameObject, isSelect and self._data.unlock)

	if isSelect then
		goutil.setActive(self._btnNormal.gameObject, false)
	else
		goutil.setActive(self._btnNormal.gameObject, self._data.unlock)
	end

	goutil.setActive(self._btnUnlock.gameObject, not self._data.unlock)
end

function M:_clickSelect()
	if self._clickCallBackFunc then
		self._clickCallBackFunc(self._clickCallBackHandler, self._index)
	end
end

function M:_clickNormal()
	if self._clickCallBackFunc then
		self._clickCallBackFunc(self._clickCallBackHandler, self._index)
	end
end

function M:_clickUnLock()
	if not self._data.unlock then
		if self._data.id - 1 > 0 then
			local previous = false

			for _, v in ipairs(TeamModel.instance:getTeamData():getMoList()) do
				if v.id == self._data.id - 1 then
					previous = v.unlock

					break
				end
			end

			if not previous then
				FloatWordMgr.instance:show("请解锁上一编队")

				return
			end
		end

		if self._data.level > 0 and PlayerModel.instance:getLevel() < self._data.level then
			FloatWordMgr.instance:show(string.format("主管职级%s开启", StringUtil.convertLevel(self._data.level)))

			return
		end

		local itemid = false
		local num = false
		local len = self._data.cost and #self._data.cost or 0

		if len == 1 then
			itemid = self._data.cost[len].id
			num = self._data.cost[len].num

			printWarn("UI迭代，team unlock tips已删除")
		end
	end
end

function M:_clickChangeName()
	if self._data.unlock then
		printWarn("UI迭代，edit_team_name_tips已删除")
	end
end

function M:OnDestroy()
	self._data = nil

	self._btnSelect:RemoveClickListener()
	self._btnNormal:RemoveClickListener()
	self._btnUnlock:RemoveClickListener()
	self._btnChangeName:RemoveClickListener()
end

return M

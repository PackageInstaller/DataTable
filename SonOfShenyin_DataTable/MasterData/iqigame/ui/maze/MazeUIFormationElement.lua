-- chunkname: @IQIGame\\UI\\Maze\\MazeUIFormationElement.lua

local CommonRoleStar = require("IQIGame.UI.Common.RoleStar.CommonRoleStar")
local HeroItem = {
	itemIndex = 0,
	heroCid = 0
}

function HeroItem.New(view, index, clickHandler, nextFormationClickHandler, type)
	local obj = Clone(HeroItem)

	obj:__Init(view, index, clickHandler, nextFormationClickHandler, type)

	return obj
end

function HeroItem:__Init(view, index, clickHandler, nextFormationClickHandler, type)
	self.gameObject = view
	self.clickHandler = clickHandler
	self.nextFormationClickHandler = nextFormationClickHandler
	self.type = type
	self.itemIndex = index

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.__delegateOnClickEvent()
		self:__OnClickEvent()
	end

	function self.__delegateOnClickNextFormationBtn()
		self:__OnClickNextFormationBtn()
	end

	self.gameObject:GetComponent("Button").onClick:AddListener(self.__delegateOnClickEvent)
	self.nextFromationBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnClickNextFormationBtn)
	self:RefreshState()
end

function HeroItem:__OnClickEvent()
	if self.clickHandler == nil then
		return
	end

	self.clickHandler(self.itemIndex)
end

function HeroItem:__OnClickNextFormationBtn()
	if self.nextFormationClickHandler ~= nil then
		self.nextFormationClickHandler(self.itemIndex)
	end
end

function HeroItem:Show()
	self.gameObject:SetActive(true)
	self:Refresh(0)
end

function HeroItem:SetLockState(state)
	LuaUtility.SetGameObjectShow(self.lockParent, state)

	self.gameObject:GetComponent("Button").interactable = not state

	if state then
		if self.type == 1 then
			LuaUtility.SetGameObjectShow(self.unLockParent, false)
		else
			LuaUtility.SetGameObjectShow(self.reserveParent, false)
		end
	end
end

function HeroItem:RefreshState()
	self.heroCid = 0

	LuaUtility.SetGameObjectShow(self.lockParent, false)
	LuaUtility.SetGameObjectShow(self.inFormation, false)
	LuaUtility.SetGameObjectShow(self.nextFromationBtn, false)
	LuaUtility.SetGameObjectShow(self.unLockParent, self.type == 1)
	LuaUtility.SetGameObjectShow(self.reserveParent, self.type == 2)
end

function HeroItem:Refresh(heroCid)
	self.heroCid = heroCid

	LuaUtility.SetGameObjectShow(self.unLockParent, self.type == 1 and heroCid ~= 0)
	LuaUtility.SetGameObjectShow(self.reserveParent, self.type == 2 and heroCid ~= 0)
	LuaUtility.SetGameObjectShow(self.nextFromationBtn, heroCid ~= 0)

	if heroCid == 0 then
		LuaUtility.SetGameObjectShow(self.inFormation, false)

		return
	end

	LuaUtility.SetGameObjectShow(self.inFormation, true)

	local warlockData = WarlockModule.GetHeroData(heroCid)
	local heroCfg = warlockData:GetCfg()

	UGUIUtil.SetText(self.heroLv, "LV." .. warlockData.lv)

	local path = warlockData:GetCurStaticSkinImagePath(Constant.SkinImageType.HeroResourcesHead)

	AssetUtil.LoadImage_SetNativeSize(self, path, self.heroIcon)
end

function HeroItem:Hide()
	self.gameObject:SetActive(false)
end

function HeroItem:Dispose()
	self.gameObject:GetComponent("Button").onClick:RemoveListener(self.__delegateOnClickEvent)
	self.nextFromationBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnClickNextFormationBtn)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local Element = {
	substituteCount = 0,
	curSelectItemIndex = 0,
	stageCid = 0,
	mainTeamHeroCount = 0,
	totalHeroCount = 0,
	teamHeroItems = {},
	selectHeroCidList = {}
}

function Element.New(view, selectHeroHandler)
	local obj = Clone(Element)

	obj:__OnInit(view, selectHeroHandler)

	return obj
end

function Element:__OnInit(view, selectHeroHandler)
	self.gameObject = view
	self.selectHeroHandler = selectHeroHandler

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.mainTeamHeroCount = self.heroList.transform.childCount

	local heroItemIndex = 0

	ForTransformChild(self.heroList.transform, function(trans, _)
		heroItemIndex = heroItemIndex + 1

		local item = HeroItem.New(trans.gameObject, heroItemIndex, function(_index)
			self:__OnTeamHeroItemClick(_index)
		end, function(_index)
			self:__OnNextFormationEvent(_index)
		end, 1)

		table.insert(self.teamHeroItems, item)
	end)
	ForTransformChild(self.substituteRoot.transform, function(trans, _)
		heroItemIndex = heroItemIndex + 1

		local item = HeroItem.New(trans.gameObject, heroItemIndex, function(_index)
			self:__OnTeamHeroItemClick(_index)
		end, function(_index)
			self:__OnNextFormationEvent(_index)
		end, 2)

		table.insert(self.teamHeroItems, item)
	end)

	function self.__delegateOnMazeFormationHeroSelected(_heroCid)
		self:__OnMazeFormationHeroSelected(_heroCid)
	end

	EventDispatcher.AddEventListener(EventID.MazeFormationHeroSelected, self.__delegateOnMazeFormationHeroSelected)
end

function Element:__OnTeamHeroItemClick(index)
	self.curSelectItemIndex = index

	local userdata = {
		[2] = Constant.UIControllerName.MazeUI,
		[3] = self.selectHeroCidList
	}

	UIModule.Open(Constant.UIControllerName.WarlockChoosePanel, Constant.UILayer.UI, userdata)
end

function Element:__OnNextFormationEvent(index)
	self.selectHeroCidList[index] = nil

	self.teamHeroItems[index]:Refresh(0)
	self.teamHeroItems[index]:RefreshState()

	if self.selectHeroHandler then
		self.selectHeroHandler(self.teamHeroItems, self.mainTeamHeroCount)
	end
end

function Element:__OnMazeFormationHeroSelected(heroCid)
	local lastIndex = 0

	ForArray(self.teamHeroItems, function(_index, _item)
		if _index > self.totalHeroCount then
			return true
		end

		if _item.heroCid == heroCid then
			lastIndex = _index

			return true
		end
	end)

	if lastIndex == self.curSelectItemIndex then
		return
	end

	if lastIndex ~= 0 then
		self.teamHeroItems[lastIndex]:Refresh(0)

		self.selectHeroCidList[lastIndex] = nil
	end

	self.teamHeroItems[self.curSelectItemIndex]:Refresh(heroCid)

	self.selectHeroCidList[self.curSelectItemIndex] = heroCid

	if self.selectHeroHandler then
		self.selectHeroHandler(self.teamHeroItems, self.mainTeamHeroCount)
	end
end

function Element:SetData(stageCid)
	self.stageCid = stageCid
	self.selectHeroCidList = {}

	local maxHeroNum = CfgDiscreteDataTable[205].Data[1]

	self.totalHeroCount = maxHeroNum
	self.substituteCount = maxHeroNum - self.mainTeamHeroCount

	ForArray(self.teamHeroItems, function(_index, _item)
		_item:RefreshState()

		if _index <= self.totalHeroCount then
			_item:SetLockState(false)
		else
			_item:SetLockState(true)
		end
	end)

	local labyrinthDataPOD = MazeModule.GetLabyrinthData()

	ForPairs(labyrinthDataPOD.preHeros, function(_position, _heroCid)
		local realIndex = _position / 2

		self.teamHeroItems[realIndex]:Refresh(_heroCid)

		self.selectHeroCidList[realIndex] = _heroCid
	end)
	ForArray(labyrinthDataPOD.replaceHeros, function(_index, _heroCid)
		local realIndex = self.mainTeamHeroCount + _index

		self.teamHeroItems[realIndex]:Refresh(_heroCid)

		self.selectHeroCidList[realIndex] = _heroCid
	end)

	if self.selectHeroHandler then
		self.selectHeroHandler(self.teamHeroItems, self.mainTeamHeroCount)
	end
end

function Element:Show()
	self.gameObject.gameObject:SetActive(true)
end

function Element:Hide()
	self.gameObject.gameObject:SetActive(false)
end

function Element:Dispose()
	EventDispatcher.RemoveEventListener(EventID.MazeFormationHeroSelected, self.__delegateOnMazeFormationHeroSelected)
	ForArray(self.teamHeroItems, function(_, _item)
		_item:Dispose()
	end)
	ForArray(self.substituteHeroItems, function(_, _item)
		_item:Dispose()
	end)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return Element

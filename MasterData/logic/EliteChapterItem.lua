-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotcopy/view/EliteChapterItem.lua

module("logic.extensions.plotcopy.view.EliteChapterItem", package.seeall)

local EliteChapterItem = class("EliteChapterItem")
local LuaComponentContainer = Framework.LuaComponentContainer

function EliteChapterItem.AddOnce(go)
	local component = LuaComponentContainer.Get(go, EliteChapterItem)

	component = component or LuaComponentContainer.Add(go, EliteChapterItem)

	return component
end

function EliteChapterItem:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self._imgBg = goutil.findChild(go, "imgBg"):GetComponent(goutil.Type_UIImage)
	self._txtName = goutil.findChild(go, "txtName"):GetComponent(goutil.Type_UIText)
	self._imgLocked = goutil.findChild(go, "imgLocked")
	self._btnClick = Framework.ButtonAdapter.GetFrom(go, "btnClick")
	self._imgRedPoint = goutil.findChild(go, "imgRedPoint")
	self._imgNew = goutil.findChild(go, "imgNew")
	self._txtLocked = goutil.findChild(go, "imgLocked/txtLocked"):GetComponent(goutil.Type_UIText)
end

function EliteChapterItem:OnDestroy()
	printInfo("EliteChapterItem Destroy", self._index)
end

function EliteChapterItem:init(index, data, view)
	printInfo("初始化EliteChapterItem", index)

	self._index = index
	self._data = data
	self._view = view

	self._btnClick:AddClickListener(self._onBtnClick, self)

	self._txtName.text = data.cfg.chapterName

	self._imgLocked:SetActive(data.isLock)
	self._imgRedPoint:SetActive(data.isShowRedPoint)
	self:_setIsNewChapter()
	uGuiUtil.setSpriteToImage(self._imgBg.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCopyChapterBgUrl(data.cfg.chapterPic))

	local val = data.isLock and 0.5 or 1

	Game.ImageUtil.SetColorRGBA(self._imgBg, val, val, val, 1)

	if data.isLock then
		local cfgPre = CopyConfig.instance:getChapter(data.cfg.preChapter)

		if cfgPre then
			local chapters = CopyConfig.instance:getChapters(cfgPre.chapterType)
			local num = table.indexof(chapters, cfgPre)

			self._txtLocked.text = string.format("完成第%s章 主线剧情开启", GameUtil.getChineseNumber(num))
		else
			self._txtLocked.text = ""
		end
	end
end

function EliteChapterItem:reset()
	self._data = nil
	self._view = nil

	self._btnClick:RemoveClickListener()
end

function EliteChapterItem:_onBtnClick()
	if self._data.isLock then
		PlotCopyModel.instance:showLockTips(self._data.cfg)

		return
	else
		PlotCopyController.instance:openChapterView(self._data.cfg.chapterId)
	end
end

function EliteChapterItem:_setIsNewChapter()
	if self._data.isLock then
		self._imgNew:SetActive(false)

		return
	end

	local name = RoleModel.instance:getUserId() .. CopyConst.isNewChatper .. self._data.cfg.chapterId
	local num = UnityEngine.PlayerPrefs.GetInt(name)
	local isNew = num == 0

	self._imgNew:SetActive(isNew)
end

return EliteChapterItem

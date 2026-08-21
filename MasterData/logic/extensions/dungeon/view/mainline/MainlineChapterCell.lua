-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/mainline/MainlineChapterCell.lua

module("logic.extensions.dungeon.view.mainline.MainlineChapterCell", package.seeall)

local M = class("MainlineChapterCell")
local kUnlockAnim = "instance_chapter_item"
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self.mainGO = self._compContainer.gameObject
	self._trs = self.mainGO.transform
end

function M:Awake()
	self:onInit()
end

function M:onInit()
	self._animation = self.mainGO:GetComponent(ComponentType.Animation)
	self._lockGo = goutil.findChild(self.mainGO, "lock")
	self._lockTxt = goutil.findChildTextComponent(self.mainGO, "lock/Text1")
	self._contentGo = goutil.findChild(self.mainGO, "content")
	self._contentCanvas = self._contentGo:GetComponent(ComponentType.CanvasGroup)
	self._imgBg = goutil.findChildImageComponent(self.mainGO, "content/icon")
	self._imgName = goutil.addComponentOnce(goutil.findChild(self.mainGO, "content/ImageLocalization"), ComponentType.ImageLocalization)
	self._goRedDot = goutil.findChild(self.mainGO, "red_point")
	self._clickBtn = ButtonAdapter.Get(goutil.findChild(self.mainGO, "click"))

	self._clickBtn:AddClickListener(self._onClickChapter, self)

	self._txtEp = goutil.findChildTextComponent(self.mainGO, "content/txtEp")
	self._imgPart = goutil.findChildImageComponent(self.mainGO, "content/ImagePart")
	self._txtProgressNormal = goutil.findChildTextComponent(self.mainGO, "content/txtNormalProgress")
	self._txtProgressDifficulty = goutil.findChildTextComponent(self.mainGO, "content/txtDifficultProgress")
end

function M:setData(chapterMOList)
	self._chapterMOList = chapterMOList
	self._chapterMO = chapterMOList[1]

	self:_tryShowUnlockAnim()
	self:_refreshCell()
end

function M:_tryShowUnlockAnim()
	local hasShow = DungeonMainLineChapterModel.instance:getDungeonChapterCache(self._chapterMO:getChapterId())

	if not hasShow and self._chapterMO:getIsChapterUnlock() then
		AnimationUtils.ResetAnimation(self._animation, kUnlockAnim)
		self._animation:Play(kUnlockAnim)
	else
		AnimationUtils.ResetToLastFrame(self._animation, kUnlockAnim)
		self._animation:Stop()
	end
end

function M:_chapterHasRedDot()
	local normalRedDot = self._chapterMO:hasRedDot()

	if normalRedDot then
		return true
	end

	if #self._chapterMOList > 1 then
		local chapterMO = self._chapterMOList[2]

		return chapterMO:hasRedDot()
	end

	return false
end

function M:_refreshCell()
	local chapterCO = self._chapterMO:getChapterCO()

	IconLoader.setSprite(self._imgBg, IconType.MainlineDungeon, chapterCO.iconRes)
	self._imgName:SetSprite(chapterCO.chapterNameRes)

	local hasRedDot = self:_chapterHasRedDot()
	local isChpaterUnlock = self._chapterMO:getIsChapterUnlock()

	goutil.setActive(self._goRedDot, hasRedDot and isChpaterUnlock)

	if isChpaterUnlock then
		self._contentCanvas.alpha = 1

		goutil.setActive(self._lockGo, false)
	else
		self._contentCanvas.alpha = 0.8

		goutil.setActive(self._lockGo, true)

		self._lockTxt.text = self:_parseForLockStr()
	end

	local partImgName = DungeonEnum.MainLinePartImg[chapterCO.chapterId]

	goutil.setActive(self._imgPart.gameObject, partImgName)

	if partImgName then
		IconLoader.setSprite(self._imgPart, IconType.DynSpriteAtlas_Dungeon, partImgName)
	end

	self._txtEp.text = "EP " .. string.format("%02d", chapterCO.chapterId)

	local normalMo = self._chapterMOList[1]
	local hardMo = self._chapterMOList[2]

	self._txtProgressNormal.text = ""
	self._txtProgressDifficulty.text = ""

	if normalMo then
		self._txtProgressNormal.text = normalMo:getUnlockDungeonCount() .. "/" .. TableUtil.getLen(normalMo:getDungeonIds())
	end

	if hardMo then
		self._txtProgressDifficulty.text = hardMo:getUnlockDungeonCount() .. "/" .. TableUtil.getLen(hardMo:getDungeonIds())
	end
end

function M:_parseForLockStr()
	return self._chapterMO:getChapterLockString()
end

function M:_onClickChapter()
	if not self._chapterMO:getIsChapterUnlock() then
		local hint = string.format(lang("tip_player_not_reach_level"), StringUtil.convertLevel(self._chapterMO:getChapterCO().unlockLv))

		FloatWordMgr.instance:show(hint)

		return
	end

	local chapterId = self._chapterMO:getChapterId()
	local difficulty = 1
	local chapterInfo = {}
	local info = Astral.LocalStorage.Instance:GetString("mainline_record")
	local id = Astral.LocalStorage.Instance:GetString("dungeon_latest_id")

	chapterInfo.chapterId = chapterId
	chapterInfo.dungeonIndex = self._chapterMO:getLastUnlockDungeonIndex() or 1
	chapterInfo.difficulty = difficulty
	chapterInfo.needShowChapterSelect = true

	AnimationUtils.ResetToLastFrame(self._animation)
	DungeonMainLineChapterModel.instance:tryEnterChapterScene(false, chapterInfo)
end

function M:OnDestroy()
	self._clickBtn:RemoveClickListener()
end

return M

local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local RU = require("Common/RedMarkUtil")
local m_novel

function Start()
  WU.BindButtonEvent(REF["$"], OnSlotClick)
end

function OnDisable()
  if m_novel then
    this:Unbind("Collections/Novels/" .. m_novel.novelId, OnNovelChanged)
    m_novel = nil
  end
end

function SetData(novel)
  if m_novel then
    this:Unbind("Collections/Novels/" .. m_novel.novelId, OnNovelChanged)
  end
  m_novel = novel
  WU.ToggleRendering(REF["$"], m_novel ~= nil)
  if m_novel then
    this:Bind("Collections/Novels/" .. m_novel.novelId, OnNovelChanged)
    REF["$"].UIPlayTween:Play(true)
  end
end

function OnNovelChanged(novel)
  m_novel = novel
  REF.SpriteCover.UISprite.spriteName = "book_" .. m_novel.curCover
  REF.SpriteCover.UISprite.alpha = fif(not m_novel.isOpen or not m_novel.unlock or m_novel.curRewardNum == 0, 0.5, 1)
  WU.ToggleRendering(REF.NotOpen, not m_novel.isOpen)
  WU.ToggleRendering(REF.SpriteRedPoint, m_novel.isOpen and m_novel.unlock and m_novel.canGetReward)
  REF["@redState"] = m_novel.isOpen and m_novel.unlock and m_novel.canGetReward
  REF["@notOpenState"] = not m_novel.isOpen
  RU.SetRedMark("Journey/CollectionsNovel/" .. m_novel.novelId, REF["@redState"])
end

function OnSlotClick(go)
  WU.RecordButtonClick(100136201)
  if m_novel and m_novel.isOpen then
    WU.AcquireWindowAsync("CollectionsNovelDetail", function(w)
      _ENV["$"](w)["$$SetNovel"](m_novel)
    end)
  end
end

function ToggleStateUI(flag)
  if flag then
    WU.ToggleRendering(REF.SpriteRedPoint, REF["@redState"])
    WU.ToggleRendering(REF.NotOpen, REF["@notOpenState"])
  else
    WU.ToggleRendering(REF.SpriteRedPoint, false)
    WU.ToggleRendering(REF.NotOpen, false)
  end
end

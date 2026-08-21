local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local m_chapterId, m_index

function SetData(chapterCategory, chapterId, index)
  m_index = index
  if m_chapterId ~= chapterId then
    if m_chapterId then
      WU.RemoveAllChild(REF["$"])
    end
    m_chapterId = chapterId
    if m_chapterId then
      local number = m_chapterId
      if chapterCategory == "ChapterStory" then
        number = m_chapterId
      end
      local chapter = CS.ResourceManager.Instance:InstantiateWindowPrefab(chapterCategory .. "/WidgetChapter" .. number)
      if chapter then
        local transform = chapter.transform
        transform.parent = REF["$transform"]
        transform.localPosition = CS.UnityEngine.Vector3.zero
        transform.localRotation = CS.UnityEngine.Quaternion.identity
        transform.localScale = CS.UnityEngine.Vector3.one
        local refChapter = _ENV["$"](chapter)
        refChapter["$$SetChapterId"](chapterId)
        if refChapter.UIScrollView then
          WU.HandleGameObjectAttached(refChapter.UIScrollView.gameObject)
        end
      else
        error("Chapter", chapterCategory .. "/WidgetChapter" .. number .. " doesn't exist.")
      end
    end
  end
end

function Close()
  if m_chapterId ~= nil then
    REF["$transform"]:GetChild(0):GetComponent(typeof(CS.UnityEngine.Animator)):Play("Close", -1, 0)
  end
end

function Open(chapterId, chapterType)
  if m_chapterId ~= chapterId then
    if m_chapterId then
      WU.RemoveAllChild(REF["$"])
    end
    m_chapterId = chapterId
    if m_chapterId then
      local number = (m_chapterId - 1) % 8 + 1
      local chapter = CS.ResourceManager.Instance:InstantiateWindowPrefab(chapterType .. "/WidgetChapter" .. number)
      if chapter then
        local transform = chapter.transform
        transform.parent = REF["$transform"]
        transform.localPosition = CS.UnityEngine.Vector3.zero
        transform.localRotation = CS.UnityEngine.Quaternion.identity
        transform.localScale = CS.UnityEngine.Vector3.one
        REF["$transform"]:GetChild(0):GetComponent(typeof(CS.UnityEngine.Animator)):Play("Open", -1, 0)
        local refChapter = _ENV["$"](chapter)
        refChapter["$$SetChapterId"](chapterId)
        if refChapter.DunScrollView then
          WU.HandleGameObjectAttached(refChapter.DunScrollView.gameObject)
        end
      else
        error("Chapter", chapterType .. "/WidgetChapter" .. number .. " doesn't exist.")
      end
    end
  else
    local chapter = REF["$transform"]:GetChild(0)
    chapter:GetComponent(typeof(CS.UnityEngine.Animator)):Play("Open", -1, 0)
    _ENV["$"](chapter)["$$SetChapterId"](chapterId)
  end
  this:DelayInvokeInSeconds(0.5, function()
    WU.SetLockFlag(PB.enum.LockInputFlag.UITransition, false)
  end)
end

function GetIndex()
  return m_index
end

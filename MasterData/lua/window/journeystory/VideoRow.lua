local WU, DB, REF = require("Common/WindowUtil")(this)

function ShowCustom(videoInfo)
  if videoInfo == nil then
    WU.SetActive(REF["$"], false)
    return
  end
  WU.SetActive(REF["$"], true)
  REF["@type"] = 1
  WU.SetActive(REF.Videos, true)
  WU.SetActive(REF.Desc, false)
  WU.SetActive(REF.Empty, false)
  WU.TraverseChildren(REF.Videos, function(g, index)
    if videoInfo[index + 1] ~= nil then
      _ENV["$"](g)["$$ShowCustom"](videoInfo[index + 1])
    else
      _ENV["$"](g)["$$ClearSlot"]()
    end
  end)
end

function ShowNone()
  REF["@type"] = 3
  WU.SetActive(REF.Empty, true)
  WU.SetActive(REF.Videos, false)
  WU.SetActive(REF.Desc, false)
end

function ShowDesc(videoInfo)
  if videoInfo == nil then
    WU.SetActive(REF["$"], false)
    return
  end
  WU.SetActive(REF["$"], true)
  REF["@type"] = 2
  WU.SetActive(REF.Videos, false)
  WU.SetActive(REF.Desc, true)
  WU.SetActive(REF.Empty, false)
  REF.LableTitle.UILabel.text = videoInfo.Desc
end

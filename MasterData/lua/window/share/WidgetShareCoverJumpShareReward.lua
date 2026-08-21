local WU, DB, REF = require("Common/WindowUtil")(this)

function SetShareInfo(data)
  WU.TraverseChildren(REF.root, function(go, i)
    go:SetActive(false)
  end)
  if REF["" .. data.activityId] then
    REF["" .. data.activityId].gameObject:SetActive(true)
  end
end

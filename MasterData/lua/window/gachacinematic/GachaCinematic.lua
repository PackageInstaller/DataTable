local WU, DB, REF = require("Common/WindowUtil")(this)
local S = require("Common/Singleton")
local U = require("Common/Util")
local m_stage

function PlayCinematic(cenimatic, callback)
  WU.RemoveAllChild(REF.Stage)
  m_stage = _ENV["$"](WU.InstantiateWindowPrefab(REF.Stage, "GachaCinematic/Stage" .. cenimatic, cenimatic))
  CS.UIWindowManager.Instance:AdjustWindowDepth(this)
  if m_stage ~= nil then
    m_stage["$gameObject"]:SetActive(true)
    m_stage["$$Reset"](callback)
  end
end

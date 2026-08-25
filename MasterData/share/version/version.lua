local M = {}
M.FeatureZone = {Global = 1, Japan = 2}

function M.GetVersion()
  return "20260824_260"
end

function M.GetFeatureZone()
  return M.FeatureZone.Global
end

function M.GetSteamMiniBundleVersion()
  return 16
end

local PackageShortName = {
  ["com.qookkagames.z1.hk"] = "iOS.Global",
  ["com.sialiagames.z1.tw"] = "iOS.TW",
  ["com.qookkagames.z1.gp.hk"] = "GP.Global",
  ["com.sialiagames.z1.gp.twnew"] = "GP.TW",
  ["com.qookkagames.z1.gw.hk"] = "OAN.Global",
  ["com.qookkagames.z1.pc.hk"] = "OPC.Global",
  ["com.sialiagames.z1.pc.tw"] = "OPC.TW",
  ["com.lingxigames.z1.steam.global"] = "Steam.Global"
}

function M.GetPkgShortName(pkgName)
  return PackageShortName[pkgName] or pkgName
end

local PackageOfficialWebsite = {
  ["com.qookkagames.z1.hk"] = "https://morimens.qookkagames.com/",
  ["com.sialiagames.z1.tw"] = "https://morimens.sialiagamesinc.com.tw/",
  ["com.qookkagames.z1.gp.hk"] = "https://morimens.qookkagames.com/",
  ["com.sialiagames.z1.gp.twnew"] = "https://morimens.sialiagamesinc.com.tw/",
  ["com.qookkagames.z1.gw.hk"] = "https://morimens.qookkagames.com/",
  ["com.qookkagames.z1.pc.hk"] = "https://morimens.qookkagames.com/",
  ["com.sialiagames.z1.pc.tw"] = "https://morimens.sialiagamesinc.com.tw/",
  ["com.lingxigames.z1.steam.global"] = "https://store.steampowered.com/app/3052450/_/",
  ["jp.co.altplus.boukyakuzenya"] = "https://www.bokyakuzenya.com/",
  ["com.qookkagames.z1.gw.hk_dev_v2"] = "https://morimens.qookkagames.com/",
  ["com.ejoy.z1"] = "https://morimens.qookkagames.com/"
}

function M.GetOfficialWebsite(pkgName)
  return PackageOfficialWebsite[pkgName]
end

setmetatable(M, {
  __call = M.GetVersion
})
return M

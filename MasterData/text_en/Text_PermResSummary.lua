__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_PermResSummary = readonly({
  PermResSummary_133963_Desc = {
    Text = [[
Game Records&{s1}#All Pick Level&{s2}#
Draft Pick Level&{s3}#]]
  },
  PermResSummary_133964_Desc = {
    Text = [[
Faded Legacy  Normal&{s1}#Faded Legacy  Hard &{s2}#
Astral Reign  Normal &{s3} #Astral Reign  Hard &{s4} #
Special Ops  Normal &{s5} #Special Ops  Hard &{s6} #
Psyche Deepdive  Normal &{s7} #Psyche Deepdive  Hard &{s8} #
Dreamscape  Normal &{s9} #Dreamscape  Hard &{s10} #
Multiverse Link  Normal &{s11} #Multiverse Link  Hard &{s12} #
Reproduction Frenzy  Clear Reward &{s13} #]]
  },
  PermResSummary_133965_Desc = {
    Text = [[
Dissolution Ruins&{s1}#Verboten Covenant&{s2}#
Lightless Realm-Chaos&{s3}#Lightless Realm-Aequor&{s4}#
Lightless Realm-Caro&{s5}#Lightless Realm-Ultra&{s6}#
Arcane Dominion&{s7}#]]
  },
  PermResSummary_133966_Desc = {
    Text = "Wayfare Frames&{s1}#Train Upgrades&{s2}#"
  },
  PermResSummary_133967_Desc = {
    Text = "Deep Dive Record&{s1}#Deep Dive Level&{s2}#"
  }
})
return Text_PermResSummary

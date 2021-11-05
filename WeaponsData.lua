local ffi = ffi
ffi.cdef [[
    typedef void* (__cdecl* tCreateInterface)(const char* name, int* returnCode);
    void* GetProcAddress(void* hModule, const char* lpProcName);
    void* GetModuleHandleA(const char* lpModuleName);
]]
local function a(b, c)
    local d = ffi.typeof(c)
    return function(e, ...)
        assert(e ~= nil)
        if e then
            return ffi.cast(d, ffi.cast("void***", e)[0][b])(e, ...)
        end
    end
end
local function f(g, h, b, c)
    local e = ffi.cast("tCreateInterface", ffi.C.GetProcAddress(ffi.C.GetModuleHandleA(g), "CreateInterface"))(h, ffi.new("int*")) or error("invalid interface")
    local i, j = pcall(ffi.typeof, c)
    if not i then
        error(j, 2)
    end
    local k = ffi.cast(j, ffi.cast("void***", e)[0][b]) or error("invalid vtable")
    return function(...)
        return k(e, ...)
    end
end
local l = ffi.typeof("char[?]")
local m = f("localize.dll", "Localize_001", 12, "wchar_t*(__thiscall*)(void*, const char*)")
local n = f("localize.dll", "Localize_001", 16, "int(__thiscall*)(void*, wchar_t*, char*, int)")
local function o(p, q)
    local r = m(p)
    local s = l(q or 1024)
    n(r, s, q or 1024)
    return s ~= nil and ffi.string(s) or nil
end
local t = f("filesystem_stdio.dll", "VBaseFileSystem011", 0, "int(__thiscall*)(void*, void*, int, void*)")
local u = f("filesystem_stdio.dll", "VBaseFileSystem011", 2, "void*(__thiscall*)(void*, const char*, const char*, const char*)")
local v = f("filesystem_stdio.dll", "VBaseFileSystem011", 3, "void(__thiscall*)(void*, void*)")
local w = f("filesystem_stdio.dll", "VBaseFileSystem011", 7, "unsigned int(__thiscall*)(void*, void*)")
local function x(y)
    local z = u(y, "r", "MOD")
    if not z then
        return
    end
    local A = w(z)
    if not A or A < 0 then
        return
    end
    local B = l(A + 1)
    if not B then
        return
    end
    local C = t(B, A, z)
    return C and ffi.string(B, A) or nil
end
local D =
    [[
struct {
    char         __pad_0x0000[4];                       // 0x0000
    char*        console_name;                          // 0x0004
    char         __pad_0x0008[12];                      // 0x0008
    int          primary_clip_size;                     // 0x0014
    int          secondary_clip_size;                   // 0x0018
    int          primary_default_clip_size;             // 0x001c
    int          secondary_default_clip_size;           // 0x0020
    int          primary_reserve_ammo_max;              // 0x0024
    int          secondary_reserve_ammo_max;            // 0x0028
    char*        model_world;                           // 0x002c
    char*        model_player;                          // 0x0030
    char*        model_dropped;                         // 0x0034
    char*        sound_empty;                           // 0x0038
    char*        sound_single_shot;                     // 0x003c
    char*        sound_single_shot_accurate;            // 0x0040
    char         __pad_0x0044[12];                      // 0x0044
    char*        sound_burst;                           // 0x0050
    char*        sound_reload;                          // 0x0054
    char         __pad_0x0058[16];                      // 0x0058
    char*        sound_special1;                        // 0x0068
    char*        sound_special2;                        // 0x006c
    char*        sound_special3;                        // 0x0070
    char         __pad_0x0074[4];                       // 0x0074
    char*        sound_nearlyempty;                     // 0x0078
    char         __pad_0x007c[4];                       // 0x007c
    char*        primary_ammo;                          // 0x0080
    char*        secondary_ammo;                        // 0x0084
    char*        item_name;                             // 0x0088
    char*        item_class;                            // 0x008c
    bool         itemflag_exhaustible;                  // 0x0090
    bool         model_right_handed;                    // 0x0091
    bool         is_melee_weapon;                       // 0x0092
    char         __pad_0x0093[9];                       // 0x0093
    int          weapon_weight;                         // 0x009c
    char         __pad_0x00a0[8];                       // 0x00a0
    int          item_gear_slot_position;               // 0x00a8
    char         __pad_0x00ac[28];                      // 0x00ac
    int          weapon_type_int;                       // 0x00c8
    char         __pad_0x00cc[4];                       // 0x00cc
    int          in_game_price;                         // 0x00d0
    int          kill_award;                            // 0x00d4
    char*        player_animation_extension;            // 0x00d8
    float        cycletime;                             // 0x00dc
    float        cycletime_alt;                         // 0x00e0
    float        time_to_idle;                          // 0x00e4
    float        idle_interval;                         // 0x00e8
    bool         is_full_auto;                          // 0x00ec
    char         __pad_0x00ed[3];                       // 0x00ed
    int          damage;                                // 0x00f0
    float        armor_ratio;                           // 0x00f4
    int          bullets;                               // 0x00f8
    float        penetration;                           // 0x00fc
    float        flinch_velocity_modifier_large;        // 0x0100
    float        flinch_velocity_modifier_small;        // 0x0104
    float        range;                                 // 0x0108
    float        range_modifier;                        // 0x010c
    float        throw_velocity;                        // 0x0110
    char         __pad_0x0114[12];                      // 0x0114
    int          has_silencer;                          // 0x0120
    char         __pad_0x0124[4];                       // 0x0124
    int          crosshair_min_distance;                // 0x0128
    int          crosshair_delta_distance;              // 0x012c
    float        max_player_speed;                      // 0x0130
    float        max_player_speed_alt;                  // 0x0134
    float        attack_movespeed_factor;               // 0x0138
    float        spread;                                // 0x013c
    float        spread_alt;                            // 0x0140
    float        inaccuracy_crouch;                     // 0x0144
    float        inaccuracy_crouch_alt;                 // 0x0148
    float        inaccuracy_stand;                      // 0x014c
    float        inaccuracy_stand_alt;                  // 0x0150
    float        inaccuracy_jump_initial;               // 0x0154
    float        inaccuracy_jump_apex;                  // 0x0158
    float        inaccuracy_jump;                       // 0x015c
    float        inaccuracy_jump_alt;                   // 0x0160
    float        inaccuracy_land;                       // 0x0164
    float        inaccuracy_land_alt;                   // 0x0168
    float        inaccuracy_ladder;                     // 0x016c
    float        inaccuracy_ladder_alt;                 // 0x0170
    float        inaccuracy_fire;                       // 0x0174
    float        inaccuracy_fire_alt;                   // 0x0178
    float        inaccuracy_move;                       // 0x017c
    float        inaccuracy_move_alt;                   // 0x0180
    float        inaccuracy_reload;                     // 0x0184
    int          recoil_seed;                           // 0x0188
    float        recoil_angle;                          // 0x018c
    float        recoil_angle_alt;                      // 0x0190
    float        recoil_angle_variance;                 // 0x0194
    float        recoil_angle_variance_alt;             // 0x0198
    float        recoil_magnitude;                      // 0x019c
    float        recoil_magnitude_alt;                  // 0x01a0
    float        recoil_magnitude_variance;             // 0x01a4
    float        recoil_magnitude_variance_alt;         // 0x01a8
    int          spread_seed;                           // 0x01ac
    float        recovery_time_crouch;                  // 0x01b0
    float        recovery_time_stand;                   // 0x01b4
    float        recovery_time_crouch_final;            // 0x01b8
    float        recovery_time_stand_final;             // 0x01bc
    int          recovery_transition_start_bullet;      // 0x01c0
    int          recovery_transition_end_bullet;        // 0x01c4
    bool         unzoom_after_shot;                     // 0x01c8
    bool         hide_view_model_zoomed;                // 0x01c9
    char         __pad_0x01ca[2];                       // 0x01ca
    int          zoom_levels;                           // 0x01cc
    int          zoom_fov_1;                            // 0x01d0
    int          zoom_fov_2;                            // 0x01d4
    int          zoom_time_0;                           // 0x01d8
    int          zoom_time_1;                           // 0x01dc
    int          zoom_time_2;                           // 0x01e0
    char*        addon_location;                        // 0x01e4
    char         __pad_0x01e8[4];                       // 0x01e8
    float        addon_scale;                           // 0x01ec
    char*        eject_brass_effect;                    // 0x01f0
    char*        tracer_effect;                         // 0x01f4
    int          tracer_frequency;                      // 0x01f8
    int          tracer_frequency_alt;                  // 0x01fc
    char*        muzzle_flash_effect_1st_person;        // 0x0200
    char*        muzzle_flash_effect_1st_person_alt;    // 0x0204
    char*        muzzle_flash_effect_3rd_person;        // 0x0208
    char*        muzzle_flash_effect_3rd_person_alt;    // 0x020c
    char*        heat_effect;                           // 0x0210
    float        heat_per_shot;                         // 0x0214
    char*        zoom_in_sound;                         // 0x0218
    char*        zoom_out_sound;                        // 0x021c
    char         __pad_0x0220[4];                       // 0x0220
    float        inaccuracy_alt_sound_threshold;        // 0x0224
    float        bot_audible_range;                     // 0x0228
    char         __pad_0x022c[12];                      // 0x022c
    bool         has_burst_mode;                        // 0x0238
    bool         is_revolver;                           // 0x0239
    char         __pad_0x023a[2];                       // 0x023a
}
]]
local E = {
    "console_name",
    "primary_clip_size",
    "secondary_clip_size",
    "primary_default_clip_size",
    "secondary_default_clip_size",
    "primary_reserve_ammo_max",
    "secondary_reserve_ammo_max",
    "model_world",
    "model_player",
    "model_dropped",
    "sound_empty",
    "sound_single_shot",
    "sound_single_shot_accurate",
    "sound_burst",
    "sound_reload",
    "sound_special1",
    "sound_special2",
    "sound_special3",
    "sound_nearlyempty",
    "primary_ammo",
    "secondary_ammo",
    "item_name",
    "item_class",
    "itemflag_exhaustible",
    "model_right_handed",
    "is_melee_weapon",
    "weapon_weight",
    "item_gear_slot_position",
    "weapon_type_int",
    "in_game_price",
    "kill_award",
    "player_animation_extension",
    "cycletime",
    "cycletime_alt",
    "time_to_idle",
    "idle_interval",
    "is_full_auto",
    "damage",
    "armor_ratio",
    "bullets",
    "penetration",
    "flinch_velocity_modifier_large",
    "flinch_velocity_modifier_small",
    "range",
    "range_modifier",
    "throw_velocity",
    "has_silencer",
    "crosshair_min_distance",
    "crosshair_delta_distance",
    "max_player_speed",
    "max_player_speed_alt",
    "attack_movespeed_factor",
    "spread",
    "spread_alt",
    "inaccuracy_crouch",
    "inaccuracy_crouch_alt",
    "inaccuracy_stand",
    "inaccuracy_stand_alt",
    "inaccuracy_jump_initial",
    "inaccuracy_jump_apex",
    "inaccuracy_jump",
    "inaccuracy_jump_alt",
    "inaccuracy_land",
    "inaccuracy_land_alt",
    "inaccuracy_ladder",
    "inaccuracy_ladder_alt",
    "inaccuracy_fire",
    "inaccuracy_fire_alt",
    "inaccuracy_move",
    "inaccuracy_move_alt",
    "inaccuracy_reload",
    "recoil_seed",
    "recoil_angle",
    "recoil_angle_alt",
    "recoil_angle_variance",
    "recoil_angle_variance_alt",
    "recoil_magnitude",
    "recoil_magnitude_alt",
    "recoil_magnitude_variance",
    "recoil_magnitude_variance_alt",
    "spread_seed",
    "recovery_time_crouch",
    "recovery_time_stand",
    "recovery_time_crouch_final",
    "recovery_time_stand_final",
    "recovery_transition_start_bullet",
    "recovery_transition_end_bullet",
    "unzoom_after_shot",
    "hide_view_model_zoomed",
    "zoom_levels",
    "zoom_fov_1",
    "zoom_fov_2",
    "zoom_time_0",
    "zoom_time_1",
    "zoom_time_2",
    "addon_location",
    "addon_scale",
    "eject_brass_effect",
    "tracer_effect",
    "tracer_frequency",
    "tracer_frequency_alt",
    "muzzle_flash_effect_1st_person",
    "muzzle_flash_effect_1st_person_alt",
    "muzzle_flash_effect_3rd_person",
    "muzzle_flash_effect_3rd_person_alt",
    "heat_effect",
    "heat_per_shot",
    "zoom_in_sound",
    "zoom_out_sound",
    "inaccuracy_alt_sound_threshold",
    "bot_audible_range",
    "has_burst_mode",
    "is_revolver"
}
local F = {
    [0] = "knife",
    [1] = "pistol",
    [2] = "smg",
    [3] = "rifle",
    [4] = "shotgun",
    [5] = "sniperrifle",
    [6] = "machinegun",
    [7] = "c4",
    [9] = "grenade",
    [11] = "stackableitem",
    [12] = "fists",
    [13] = "breachcharge",
    [14] = "bumpmine",
    [15] = "tablet",
    [16] = "melee",
    [19] = "equipment"
}
local G = {[31] = "taser"}
local H = mem.FindPattern("client.dll", "8B 35 ?? ?? ?? ?? FF 10 0F B7 C0") or error("IWeaponSystem signature invalid")
local I = ffi.cast("void****", ffi.cast("char*", H) + 0x2)[0]
local J = a(2, D .. "*(__thiscall*)(void*, unsigned int)") or error("invalid GetCSWeaponInfo index")
local K, L = {}, {}
for M = 1, 1000 do
    local r = J(I, M)
    if r ~= nil then
        local N = {}
        for O = 1, #E do
            local P = E[O]
            local Q = r[P]
            local R, S = pcall(ffi.typeof, Q)
            if R and S == ctype_char then
                N[P] = ffi.string(Q)
            else
                N[P] = Q
            end
        end
        N.idx = M
        N.type = G[M] or F[r.weapon_type_int]
        N.svg = x("materials/panorama/images/icons/equipment/" .. ffi.string(N.console_name):gsub("^weapon_", ""):gsub("^item_", "") .. ".svg")
        N.name = o(N.item_name)
        N.raw = r
        K[M] = N
        L[N.console_name] = N
    end
end
local function T(U, V)
    if not (U == K or V or V:IsPlayer() and entities.GetPlayerResources():GetPropBool("m_bAlive", V:GetIndex())) then
        return
    end
    local M = V:GetWeaponID()
    return K[M]
end
******})
return K

----------------------------------------------EXAMPLE
local csgo_weapons = loadstring(file.Read("libraries/csgo_weapons.lua"))()

callbacks.Register(
    "Draw",
    "csgo_weapons_example",
    function()
        local weapons_data = csgo_weapons[9]
        print(weapons_data.console_name, weapons_data.name, weapons_data.item_class, weapons_data.type, weapons_data.idx, weapons_data.secondary_clip_size, weapons_data.damage)

        local lp = entities.GetLocalPlayer()
        local weapons_data = csgo_weapons(lp)
        print(weapons_data.console_name, weapons_data.name, weapons_data.item_class, weapons_data.type, weapons_data.idx, weapons_data.secondary_clip_size, weapons_data.damage)
    end
)

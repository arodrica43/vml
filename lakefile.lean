import Lake
open Lake DSL

package «vml» where
  -- add package configuration options here

lean_lib «VML» where
  -- add library configuration options here

@[default_target]
lean_exe «vml» where
  root := `Main

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "v4.13.0"

-- Note: For HoTT in Lean 4, we can use mathlib's HoTT developments
-- or work directly with the type theory foundations

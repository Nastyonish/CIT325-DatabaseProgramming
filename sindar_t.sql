SET PAGESIZE 999

SPOOL sindar_t.txt

DROP TYPE sindar_t FORCE;

-- Create a sindar_t object type and type body as a subtype of the elf_t
CREATE OR REPLACE TYPE sindar_t UNDER elf_t
( elfkind VARCHAR2(30)
, CONSTRUCTOR FUNCTION sindar_t
  ( elfkind VARCHAR2) RETURN SELF AS RESULT
, MEMBER FUNCTION get_elfkind RETURN VARCHAR2
, MEMBER PROCEDURE set_elfkind
  ( elfkind VARCHAR2)
, OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2)
INSTANTIABLE NOT FINAL;
/

DESC sindar_t

CREATE OR REPLACE TYPE BODY sindar_t IS
    CONSTRUCTOR FUNCTION sindar_t
    ( elfkind VARCHAR2) RETURN SELF AS RESULT IS
    BEGIN
        self.elfkind := elfkind;
    END sindar_t;
    
    MEMBER FUNCTION get_elfkind RETURN VARCHAR2 IS
    BEGIN
        RETURN self.elfkind;
    END get_elfkind;
    
    MEMBER PROCEDURE set_elfkind
    ( elfkind VARCHAR2) IS
    BEGIN
        self.elfkind := elfkind;
    END set_elfkind;
    
    OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2 IS
    BEGIN
        RETURN (self AS elf_t).to_string()||'['||self.elfkind||']';
    END to_string;
END;
/

SPOOL OFF

QUIT;
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

#nullable disable

namespace APIWitcher
{
    public partial class WitcherDBContext : DbContext
    {
        public WitcherDBContext()
        {
        }

        public WitcherDBContext(DbContextOptions<WitcherDBContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Activity> Activities { get; set; }
        public virtual DbSet<Beast> Beasts { get; set; }
        public virtual DbSet<Bestiary> Bestiaries { get; set; }
        public virtual DbSet<Character> Characters { get; set; }
        public virtual DbSet<Class> Classes { get; set; }
        public virtual DbSet<Component> Components { get; set; }
        public virtual DbSet<Country> Countries { get; set; }
        public virtual DbSet<Equipment> Equipment { get; set; }
        public virtual DbSet<EquipmentStructure> EquipmentStructures { get; set; }
        public virtual DbSet<EquipmentType> EquipmentTypes { get; set; }
        public virtual DbSet<Feature> Features { get; set; }
        public virtual DbSet<Image> Images { get; set; }
        public virtual DbSet<Ingredient> Ingredients { get; set; }
        public virtual DbSet<Location> Locations { get; set; }
        public virtual DbSet<LocationType> LocationTypes { get; set; }
        public virtual DbSet<Potion> Potions { get; set; }
        public virtual DbSet<PotionStructure> PotionStructures { get; set; }
        public virtual DbSet<PotionType> PotionTypes { get; set; }
        public virtual DbSet<Race> Races { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Data Source=witcherserver.database.windows.net;Initial Catalog=WitcherDB;Persist Security Info=True;User ID=maxk;Password=Joker007");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("Relational:Collation", "SQL_Latin1_General_CP1_CI_AS");

            modelBuilder.Entity<Activity>(entity =>
            {
                entity.ToTable("Activity");

                entity.HasIndex(e => e.Name, "UQ__Activity__737584F6035D7AE1")
                    .IsUnique();

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(128);
            });

            modelBuilder.Entity<Beast>(entity =>
            {
                entity.ToTable("Beast");

                entity.HasIndex(e => e.Name, "UQ__Beast__737584F6F2E09AB5")
                    .IsUnique();

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Description).IsRequired();

                entity.Property(e => e.Idclass).HasColumnName("IDClass");

                entity.Property(e => e.Idimage).HasColumnName("IDImage");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(128);

                entity.HasOne(d => d.IdclassNavigation)
                    .WithMany(p => p.Beasts)
                    .HasForeignKey(d => d.Idclass)
                    .HasConstraintName("FK__Beast__IDClass__0D7A0286");

                entity.HasOne(d => d.IdimageNavigation)
                    .WithMany(p => p.Beasts)
                    .HasForeignKey(d => d.Idimage)
                    .HasConstraintName("FK__Beast__IDImage__0E6E26BF");
            });

            modelBuilder.Entity<Bestiary>(entity =>
            {
                entity.ToTable("Bestiary");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Idbeast).HasColumnName("IDBeast");

                entity.Property(e => e.Idfeature).HasColumnName("IDFeature");

                entity.Property(e => e.Value)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.HasOne(d => d.IdbeastNavigation)
                    .WithMany(p => p.Bestiaries)
                    .HasForeignKey(d => d.Idbeast)
                    .HasConstraintName("FK__Bestiary__IDBeas__0F624AF8");

                entity.HasOne(d => d.IdfeatureNavigation)
                    .WithMany(p => p.Bestiaries)
                    .HasForeignKey(d => d.Idfeature)
                    .HasConstraintName("FK__Bestiary__IDFeat__10566F31");
            });

            modelBuilder.Entity<Character>(entity =>
            {
                entity.ToTable("Character");

                entity.HasIndex(e => e.Name, "UQ__Characte__737584F6DF386752")
                    .IsUnique();

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Description).IsRequired();

                entity.Property(e => e.Idactivity).HasColumnName("IDActivity");

                entity.Property(e => e.Idimage).HasColumnName("IDImage");

                entity.Property(e => e.Idrace).HasColumnName("IDRace");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(128);

                entity.HasOne(d => d.IdactivityNavigation)
                    .WithMany(p => p.Characters)
                    .HasForeignKey(d => d.Idactivity)
                    .HasConstraintName("FK__Character__IDAct__114A936A");

                entity.HasOne(d => d.IdimageNavigation)
                    .WithMany(p => p.Characters)
                    .HasForeignKey(d => d.Idimage)
                    .HasConstraintName("FK__Character__IDIma__123EB7A3");

                entity.HasOne(d => d.IdraceNavigation)
                    .WithMany(p => p.Characters)
                    .HasForeignKey(d => d.Idrace)
                    .HasConstraintName("FK__Character__IDRac__1332DBDC");
            });

            modelBuilder.Entity<Class>(entity =>
            {
                entity.ToTable("Class");

                entity.HasIndex(e => e.Name, "UQ__Class__737584F6815123EC")
                    .IsUnique();

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(128);
            });

            modelBuilder.Entity<Component>(entity =>
            {
                entity.HasIndex(e => e.Name, "UQ__Componen__737584F63E1EB3AD")
                    .IsUnique();

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(255);
            });

            modelBuilder.Entity<Country>(entity =>
            {
                entity.ToTable("Country");

                entity.HasIndex(e => e.Name, "UQ__Country__737584F6954C6531")
                    .IsUnique();

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(128);
            });

            modelBuilder.Entity<Equipment>(entity =>
            {
                entity.HasIndex(e => e.Name, "UQ__Equipmen__737584F6C3147FC9")
                    .IsUnique();

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Description).IsRequired();

                entity.Property(e => e.IdequipmentType).HasColumnName("IDEquipmentType");

                entity.Property(e => e.Idimage).HasColumnName("IDImage");

                entity.Property(e => e.Location).IsRequired();

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.HasOne(d => d.IdequipmentTypeNavigation)
                    .WithMany(p => p.Equipment)
                    .HasForeignKey(d => d.IdequipmentType)
                    .HasConstraintName("FK__Equipment__IDEqu__14270015");

                entity.HasOne(d => d.IdimageNavigation)
                    .WithMany(p => p.Equipment)
                    .HasForeignKey(d => d.Idimage)
                    .HasConstraintName("FK__Equipment__IDIma__151B244E");
            });

            modelBuilder.Entity<EquipmentStructure>(entity =>
            {
                entity.ToTable("EquipmentStructure");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Idcomponent).HasColumnName("IDComponent");

                entity.Property(e => e.Idequipment).HasColumnName("IDEquipment");

                entity.Property(e => e.Value)
                    .IsRequired()
                    .HasMaxLength(128);

                entity.HasOne(d => d.IdcomponentNavigation)
                    .WithMany(p => p.EquipmentStructures)
                    .HasForeignKey(d => d.Idcomponent)
                    .HasConstraintName("FK__Equipment__IDCom__160F4887");

                entity.HasOne(d => d.IdequipmentNavigation)
                    .WithMany(p => p.EquipmentStructures)
                    .HasForeignKey(d => d.Idequipment)
                    .HasConstraintName("FK__Equipment__IDEqu__17036CC0");
            });

            modelBuilder.Entity<EquipmentType>(entity =>
            {
                entity.ToTable("EquipmentType");

                entity.HasIndex(e => e.Name, "UQ__Equipmen__737584F65AFAEABE")
                    .IsUnique();

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(255);
            });

            modelBuilder.Entity<Feature>(entity =>
            {
                entity.ToTable("Feature");

                entity.HasIndex(e => e.Name, "UQ__Feature__737584F627CFAD2F")
                    .IsUnique();

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(128);
            });

            modelBuilder.Entity<Image>(entity =>
            {
                entity.ToTable("Image");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Link).IsRequired();
            });

            modelBuilder.Entity<Ingredient>(entity =>
            {
                entity.ToTable("Ingredient");

                entity.HasIndex(e => e.Name, "UQ__Ingredie__737584F6DE6A5F4C")
                    .IsUnique();

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(128);
            });

            modelBuilder.Entity<Location>(entity =>
            {
                entity.ToTable("Location");

                entity.HasIndex(e => e.Name, "UQ__Location__737584F659014CA4")
                    .IsUnique();

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Description).IsRequired();

                entity.Property(e => e.Idcountry).HasColumnName("IDCountry");

                entity.Property(e => e.Idimage).HasColumnName("IDImage");

                entity.Property(e => e.IdtypeLocation).HasColumnName("IDTypeLocation");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(128);

                entity.HasOne(d => d.IdcountryNavigation)
                    .WithMany(p => p.Locations)
                    .HasForeignKey(d => d.Idcountry)
                    .HasConstraintName("FK__Location__IDCoun__17F790F9");

                entity.HasOne(d => d.IdimageNavigation)
                    .WithMany(p => p.Locations)
                    .HasForeignKey(d => d.Idimage)
                    .HasConstraintName("FK__Location__IDImag__1DB06A4F");

                entity.HasOne(d => d.IdtypeLocationNavigation)
                    .WithMany(p => p.Locations)
                    .HasForeignKey(d => d.IdtypeLocation)
                    .HasConstraintName("FK__Location__IDType__18EBB532");
            });

            modelBuilder.Entity<LocationType>(entity =>
            {
                entity.ToTable("LocationType");

                entity.HasIndex(e => e.Name, "UQ__Location__737584F60AB5E34A")
                    .IsUnique();

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(128);
            });

            modelBuilder.Entity<Potion>(entity =>
            {
                entity.ToTable("Potion");

                entity.HasIndex(e => e.Name, "UQ__Potion__737584F6DE0ACF4E")
                    .IsUnique();

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Description).IsRequired();

                entity.Property(e => e.Idimage).HasColumnName("IDImage");

                entity.Property(e => e.IdpotionType).HasColumnName("IDPotionType");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(128);

                entity.HasOne(d => d.IdimageNavigation)
                    .WithMany(p => p.Potions)
                    .HasForeignKey(d => d.Idimage)
                    .HasConstraintName("FK__Potion__IDImage__19DFD96B");

                entity.HasOne(d => d.IdpotionTypeNavigation)
                    .WithMany(p => p.InverseIdpotionTypeNavigation)
                    .HasForeignKey(d => d.IdpotionType)
                    .HasConstraintName("FK__Potion__IDPotion__1AD3FDA4");

                entity.HasOne(d => d.IdpotionType1)
                    .WithMany(p => p.Potions)
                    .HasForeignKey(d => d.IdpotionType)
                    .HasConstraintName("FK__Potion__IDPotion__29221CFB");
            });

            modelBuilder.Entity<PotionStructure>(entity =>
            {
                entity.ToTable("PotionStructure");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Idingredient).HasColumnName("IDIngredient");

                entity.Property(e => e.Idpotion).HasColumnName("IDPotion");

                entity.Property(e => e.Value)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.HasOne(d => d.IdingredientNavigation)
                    .WithMany(p => p.PotionStructures)
                    .HasForeignKey(d => d.Idingredient)
                    .HasConstraintName("FK__PotionStr__IDIng__1BC821DD");

                entity.HasOne(d => d.IdpotionNavigation)
                    .WithMany(p => p.PotionStructures)
                    .HasForeignKey(d => d.Idpotion)
                    .HasConstraintName("FK__PotionStr__IDPot__1CBC4616");
            });

            modelBuilder.Entity<PotionType>(entity =>
            {
                entity.ToTable("PotionType");

                entity.HasIndex(e => e.Name, "UQ__PotionTy__737584F64992DA3A")
                    .IsUnique();

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(128);
            });

            modelBuilder.Entity<Race>(entity =>
            {
                entity.ToTable("Race");

                entity.HasIndex(e => e.Name, "UQ__Race__737584F630A903EB")
                    .IsUnique();

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(128);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
